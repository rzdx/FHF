function [ O ] = fznb( I,par,m,n,c )
I = reshape(I, m, n, c);
O=zeros(size(I,1),size(I,2),size(I,3));
Di=DI(I);
if length(par)==1
    ccc=0.006;
    www=0.003;
    B=[ccc-www,ccc,ccc+www,ccc+(2*www),0.5];
    S=[www,www,www,www,0.5];
    M=[exp(-1),1,exp(-1),exp(-4),0];
else
    B=par(1:5);
    S=par(6:10);
    M=par(11:15);
end
parfor r=1:size(I,1)
    Or=zeros(1,size(I,2),size(I,3));
    for c=1:size(I,2)
        if Di(r,c)==1
            L=Lvar(Di,r,c);
            [SbI,tr,tc]=fn.winsp(I,r,c,L);
            SbI_R = SbI(:, :, 1);
            SbI_G = SbI(:, :, 2);
            SbI_B = SbI(:, :, 3);
            SbDi=fn.winsp(Di,r,c,L);
            rmin=realmax;
            NFP=getnzfp(SbDi);
            mr=0;
            mc=0;
            for scr=1:size(SbI,1)
                for scc=1:size(SbI,2)
                    if SbDi(scr,scc)==1 % if is_noise(SbI(r,c))=true then ignore
                        continue;
                    end
                    eu=zeros(1,1,size(SbI,3));
                    ed=realmin;
                    for i=1:size(NFP,2)
                        Ip=SbI(NFP(1,i),NFP(2,i),:);
                        au=0;
                        ad=0;
                        for ai=1:length(B)
                            slsum=0;
                            ct=0;
                            for slr=1:size(SbI,1)
                                for slc=1:size(SbI,2)
                                    if SbDi(slr,slc)==1 % exclude noise points
                                        continue;
                                    end
                                    slsum = slsum + ...
                                        sqrt((Ip(1) - SbI_R(slr, slc)).^2 ...
                                        + (Ip(2) - SbI_G(slr, slc)).^2 ...
                                        + (Ip(3) - SbI_B(slr, slc)).^2);
                                    ct=ct+1;
                                end
                            end
                            silmO=slsum/(3*255*ct);
                            tu=(silmO-B(ai))^2;
                            td=2*((S(ai))^2);
                            t=exp(-(tu/td));
                            au=au+(t*M(ai));
                            ad=ad+t;
                        end
                        al=au/ad;
                        eu=eu+(al*Ip);
                        ed=ed+al;
                    end
                    estp=eu/ed;
                    sbip=SbI(scr,scc,:);
                    dt=norm(double(sbip(:))-double(estp(:))); % else then take into consideration
                    if rmin>dt
                        rmin=dt;
                        mr=scr;
                        mc=scc;
                    end
                end
            end
            sr=mr+tr-1;
            sc=mc+tc-1;
            Or(1,c,:)=I(sr,sc,:);
            % 			O(r,c,:)=I(sr,sc,:);
        else
            Or(1,c,:)=I(r,c,:);
            % 			O(r,c,:)=I(r,c,:);
        end
    end
    O(r,:,:)=Or;
end
end

function [O]=Lvar(Di,r,c) % output min length of a window centered at (r,c) with some noise-free points within
chk=0;
for L=3:2:min(size(Di,1),size(Di,2))
    SbDi=fn.winsp(Di,r,c,L);
    if sum(SbDi(:))~=size(SbDi,1)*size(SbDi,2)
        chk=1;
        break;
    end
end
if chk
    O=L;
else
    error('L out_of_bound')
end
end

function [O]=getnzfp(SbDi) % get noise-free points within sub-Di(=SbDi)
pct=size(SbDi,1)*size(SbDi,2)-sum(SbDi(:));
O=zeros(2,pct);
ct=0;
for r=1:size(SbDi,1)
    for c=1:size(SbDi,2)
        if SbDi(r,c)==0
            ct=ct+1;
            O(1,ct)=r;
            O(2,ct)=c;
        end
    end
end
end

function [O]= DI(I) % get noise_tag_matrix with 1=noise_point,0=noise-free_point
O=zeros(size(I,1),size(I,2));
for j=1:size(I,3)
    Ie=I(:,:,j);
    for i=1:size(I,1)*size(I,2)
        if Ie(i)==255||Ie(i)==0
            O(i)=1;
        end
    end
end
end
