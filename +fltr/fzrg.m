function [ O ] = fzrg( I,par ) %fuzzy range filter
L=7;
O=zeros(size(I,1),size(I,2),size(I,3));
if ~iscell(par)
    mdS=modeS(I,7);
    wa=max(realmin,0.002*mdS-0.005);
    B=[0,wa,2*wa,3*wa,(1+(3*wa))/2];
    S=[wa,wa,wa,wa,(1-(3*wa))/4];
    M=[1,3/4,1/2,1/4,0];
else
    B=par{1};
    S=par{2};
    M=par{3};
end
I_R=I(:,:,1);
I_G=I(:,:,2);
I_B=I(:,:,3);
for r=1:size(I,1)
    for c=1:size(I,2)
        SbI=fn.winsp(I,r,c,L);
        SbI_R = SbI(:, :, 1);
        SbI_G = SbI(:, :, 2);
        SbI_B = SbI(:, :, 3);
        yu=0;
        yd=0;
        for yr=1:size(SbI,1)
            for yc=1:size(SbI,2)
                bu=0;
                bd=0;
                for bi=1:length(B)
                    simO=sqrt((SbI_R(yr,yc) - I_R(r,c)).^2 ...
                        + (SbI_G(yr,yc) - I_G(r,c)).^2 ...
                        + (SbI_B(yr,yc) - I_B(r,c)).^2)/(3*255);
                    tu=(simO-B(bi))^2;
                    td=2*((S(bi))^2);
                    t=exp(-(tu/td));
                    bu=bu+(t*M(bi));
                    bd=bd+t;
                end
                bt=bu/bd;
                yu=yu+bt*SbI(yr,yc,:);
                yd=yd+bt;
            end
        end
        O(r,c,:)=yu/yd;
    end
end
end

function [O]=modeS(I,L) % mode of distribution
Sv=fltr.var(I,L);
S=zeros(size(I,1),size(I,2));
for r=1:size(I,1)
    for c=1:size(I,2)
        S(r,c)=sum(Sv(r,c,:))/size(Sv,3);
    end
end
S=round(S);
mx=max(S(:));
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
