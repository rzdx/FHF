function [minOI,minpara,minv] = EFHFde(ibv,I,nI,fltrtp) % complexity: NP*(2*Gmax+1)
Gmax=10;
NP=10;
Cr=0.8;
F=0.7;

d=15;

fhf_best=1;

evfnnm='fn.EFHFev';
Xmax=zeros(d,1)+1;
Xmin=zeros(d,1);
X=zeros(d,NP);
newX=X;
tX=zeros(d,1);
tU=tX;
for np=1:NP
    for i=1:d
        tX(i)=Xmin(i)+rand*(Xmax(i)-Xmin(i));
    end
    X(:,np)=tX;
end

%-----------fhf_ind
if fhf_best==1
    ccc=0.006;
    www=0.003;
    X(:,1)=[...
    [ccc-www;ccc;ccc+www;ccc+(2*www);0.5];...
    [www;www;www;www;0.5];...
    [exp(-1);1;exp(-1);exp(-4);0]...
    ];

    mdS=fn.modeS(nI,5);
    wa=max(realmin,0.002*mdS-0.005);
    X(:,2)=[...
    [0;wa;2*wa;3*wa;(1+(3*wa))/2];...
    [wa;wa;wa;wa;(1-(3*wa))/4];...
    [1;3/4;1/2;1/4;0]...
    ];
end
%-----------

G=1;
while G<=Gmax
    evX=evalX(X,evfnnm,I,nI,fltrtp);
    bestXidx=minX(evX);
    for i=1:NP
        %mutation
        r1 = floor(1 + NP * rand);
        r2 = floor(1 + NP * rand);
        r3 = r2;
        while r2 == r3
            r3 = floor(1 + NP * rand);
        end
        rd=[r1,r2,r3];
        
        switch ibv
            case 1 %rand
                tV=X(:,rd(1))+(F + 0.01 * randn)*(X(:,rd(2))-X(:,rd(3)));
            case 2 %best
                tV=X(:,bestXidx)+F*(X(:,rd(2))-X(:,rd(3)));
            case 3 %current-to-best
                tV=X(:,i)+F*(X(:,bestXidx)-X(:,i))+F*(X(:,rd(2))-X(:,rd(3)));
            otherwise
                error('type_not_match');
        end
        %crossover
        rdj=randi(d);
        for j=1:d
            if rand<=Cr||rdj==j
                tU(j)=tV(j);
            else
                tU(j)=X(j,i);
            end
        end
        %selction
        if feval(evfnnm,I,nI,tU,fltrtp)<=evX(i)
            newX(:,i)=tU;
        else
            newX(:,i)=X(:,i);
        end
    end
    X=newX;
    G=G+1;
end
[evX,OI]=evalX(X,evfnnm,I,nI,fltrtp);
[minidx,minv]=minX(evX);
minpara=X(:,minidx);
minOI=OI(:,:,:,minidx);
end

function [evX,OI]=evalX(X,evfnnm,I,nI,fltrtp)
evX=zeros(size(X,2),1);
OI=zeros(size(I,1),size(I,2),size(I,3),size(X,2));
for i=1:size(X,2)
    [evX(i),OI(:,:,:,i)]=feval(evfnnm,I,nI,X(:,i),fltrtp);
end
end

function [minidx,minv]=minX(evX)
idx=0;
min=realmax;
for i=1:length(evX)
    minf=evX(i);
    if min>minf
        min=minf;
        idx=i;
    end
end
minidx=idx;
minv=min;
end