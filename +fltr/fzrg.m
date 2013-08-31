function [ O ] = fzrg( I ) %fuzzy range filter
L=5;
mdS=modeS(I,7);
wa=max(realmin,0.002*mdS-0.005);
[R,C,D]=fn.getsz(I);
O=zeros(R,C,D);
for r=1:R
    for c=1:C
        SbI=fn.winsp(I,r,c,L);
        O(r,c,:)=Y(SbI,I(r,c,:),wa);
    end
end
end

function [O]=Y(SbI,Cp,wa)
[R,C]=fn.getsz(SbI);
u=0;
d=0;
for r=1:R
   for c=1:C
       bt=beta(SbI(r,c,:),Cp,wa);
       u=u+bt*SbI(r,c,:);
       d=d+bt;
   end
end
O=u/d;
end

function [O]=beta(Ip,Cp,wa)
B={0,wa,2*wa,3*wa,(1+(3*wa))/2};
S={wa,wa,wa,wa,(1+(3*wa))/4};
M={1,3/4,1/2,1/4,0};

u=0;
d=0;
for i=1:length(B)
    t=tk(Ip,Cp,B{i},S{i});
    u=u+(t*M{i});
    d=d+t;
end
O=u/d;
end

function [O]=tk(Ip,Cp,b,s) 
u=(siml(Ip,Cp)-b)^2;
d=2*((s)^2);
O=exp(u/d);
end

function [O]=siml(Ip,Cp) % ~similarity value
O=fn.dst(Ip,Cp)/(3*255);
end

function [O]=modeS(I,L) % mode of distribution 
Sv=fltr.var(I,L);
[R,C]=fn.getsz(I);
S=zeros(R,C);
for r=1:R
   for c=1:C
       S(r,c)=sum(Sv(r,c,:))/size(Sv,3);
   end
end
S=round(S);
mx=max(max(S));
Z=zeros(1,mx);
for i=1:fn.mul(size(S))
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
