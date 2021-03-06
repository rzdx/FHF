function [minv,minpara] = dfev(Gmax,NP,d,ibv,evfnnm,evn)
Cr=0.8;
F=0.7;

Xmax=zeros(d,1)+100;
Xmin=zeros(d,1)-100;
X=cell(NP,1);
newX=X;
tX=zeros(d,1);
tU=tX;
for np=1:NP
    for i=1:d
        tX(i)=Xmin(i)+rand*(Xmax(i)-Xmin(i));
    end
    X{np}=tX;
end

G=1;
while G<=Gmax
    evX=evalX(X,evfnnm,evn);
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
                tV=X{rd(1)}+(F + 0.01 * randn)*(X{rd(2)}-X{rd(3)});
            case 2 %best
                tV=X{bestXidx}+F*(X{rd(2)}-X{rd(3)});
            case 3 %target-to-best
                tV=X{i}+F*(X{bestXidx}-X{i})+F*(X{rd(2)}-X{rd(3)});
            otherwise
                error('type_not_match');
        end
        %crossover
        rdj=randi(d);
        for j=1:d
            if rand<=Cr||rdj==j
                tU(j)=tV(j);
            else
                tU(j)=X{i}(j);
            end
        end
        %selction
        if feval(evfnnm,tU,evn)<=evX(i)
            newX{i}=tU;
        else
            newX{i}=X{i};
        end
    end
    X=newX;
    G=G+1;
end
evX=evalX(X,evfnnm,evn);
[minidx,minv]=minX(evX);
minpara=X{minidx};
end

function [evX]=evalX(X,evfnnm,evn)
evX=zeros(length(X),1);
for i=1:length(X)
    evX(i)=feval(evfnnm,X{i},evn);
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