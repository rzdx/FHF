function [minv,minpara] = dfev(M,ibv,evfnnm)
Gmax=3000;
NP=50;
Cr=0.8;
F=0.7;
d=M*3;

Xmax=zeros(d,1)+5;
Xmin=zeros(d,1)-5;
X=cell(NP,1);
Xn=X;
V=X;
tX=zeros(d,1);
tU=tX;
for np=1:NP
    for i=1:d
        tX(i)=Xmin(i)+rand*(Xmax(i)-Xmin(i));
    end
    X{np}=tX;
end

G=0;
while G<=Gmax
    for i=1:NP
        %mutation
        rd=randperm(NP,3);
        switch ibv
            case 1 %rand
                V{i}=X{rd(1)}+F*(X{rd(2)}-X{rd(3)});
            case 2 %best
                V{i}=X{minX(X,evfnnm)}+F*(X{rd(1)}-X{rd(2)});
            case 3 %target-to-best
                V{i}=X{i}+F*(X{minX(X,evfnnm)}-X{i})+F*(X{rd(1)}-X{rd(2)});
            otherwise
                error('type_not_match');
        end
        %crossover
        rdj=randi(d);
        for j=1:d
            if rand<=Cr||rdj==j
                tU(j)=V{i}(j);
            else
                tU(j)=X{i}(j);
            end
        end
        %selction
        if feval(evfnnm,tU)<=feval(evfnnm,X{i})
            Xn{i}=tU;
        else
            Xn{i}=X{i};
        end
    end
    X=Xn;
    G=G+1;
end
[minidx,minv]=minX(X,evfnnm);
minpara=X{minidx};
end

function [minidx,minv]=minX(X,evfnnm)
idx=0;
min=realmax;
for i=1:length(X)
    minf=feval(evfnnm,X{i});
    if min>minf
        min=minf;
        idx=i;
    end
end
minidx=idx;
minv=min;
end