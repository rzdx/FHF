function [ O ] = fzrg( I )
wa=max(realmin,0.002*modeS(I,7)-0.005);

b={0,wa,2*wa,3*wa,(1+(3*wa))/2};
s={wa,wa,wa,wa,(1+(3*wa))/4};
m={1,3/4,1/2,1/4,0};

end

function [O]=modeS(I,L)
Sv=Fltr.var(I,L);
[R,C]=Fn.getsz(I);
S=zeros(R,C);
for r=1:R
   for c=1:C
       S(r,c)=sum(Sv(r,c,:))/size(Sv,3);
   end
end
S=round(S);
mx=max(max(S));
Z=zeros(1,mx);
for i=1:Fn.mul(size(S))
    Z(S(i))=Z(S(i))+1;
end
rmax=realmin;
for j=1:mx
    if Z(j)>rmax
        rmax=Z(j);
        maxS=j;
    end
end
O=round(sqrt(maxS));
end