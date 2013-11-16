function [O]=modeS(I,L) % mode of distribution
Sv=fltr.var(I,L);
S=zeros(size(I,1),size(I,2));
for r=1:size(I,1)
    for c=1:size(I,2)
        S(r,c)=sum(Sv(r,c,:))/size(Sv,3);
    end
end
S=round(S);
mx=max(S(:))+1;
Z=zeros(1,mx);
for i=1:fn.mul(size(S))
    Z(S(i)+1)=Z(S(i)+1)+1;
end
rmax=realmin;
maxS=0;
for j=1:mx
    if Z(j)>rmax
        rmax=Z(j);
        maxS=j;
    end
end
O=round(sqrt(maxS-1));
end