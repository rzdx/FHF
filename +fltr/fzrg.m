function [ O ] = fzrg( I,L )
mdS=modeS(I,7);
wa=max(realmin,0.002*mdS-0.005);
[R,C,D]=fn.getsz(I);
O=zeros(R,C,D);
PdI=fn.padd(I,L);
padtag=ones(R,C);
Pdpadtag=fn.padd(padtag,L);
Lh=(L-1)/2;
for r=1:R
    for c=1:C
        rr=r+Lh*2;
        cc=c+Lh*2;
        SbPdI=PdI(rr-Lh:rr+Lh,cc-Lh:cc+Lh,:);
        SbPdpadtag=Pdpadtag(rr-Lh:rr+Lh,cc-Lh:cc+Lh);
        O(r,c,:)=Y(SbPdI,SbPdpadtag,PdI(rr,cc,:),wa);
    end
end
end

function [O]=Y(SbPdI,SbPdpadtag,Cp,wa)
[R,C]=fn.getsz(SbPdI);
u=0;
d=0;
for r=1:R
   for c=1:C
       if SbPdpadtag(r,c)==0
            continue;
       end
       bt=beta(SbPdI(r,c,:),Cp,wa);
       u=u+bt*SbPdI(r,c,:);
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

function [O]=siml(Ip,Cp) %Ip=I(NFPcordR,NFPcordC,:)
MAXI=255;
O=fn.dst(Ip,Cp)/(3*MAXI);
end

function [O]=modeS(I,L)
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
