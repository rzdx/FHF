function [ O ] = fznb( I ) % fuzzy neighbor filter
di=DI(I);
O=Y(I,di);
end

function [O]=Y(I,Di) % output result pixel
[R,C,D]=fn.getsz(I);
O=zeros(R,C,D);
%nosleft=sum(sum(Di));
    for r=1:R
        for c=1:C
            if Di(r,c)==1
                %nosleft=nosleft-1 
                L=Lvar(Di,r,c);
                [SbI,tr,tc]=fn.winsp(I,r,c,L);
                SbDi=fn.winsp(Di,r,c,L);
                [sr,sc]=scord(SbI,SbDi,tr,tc,getnzfp(SbDi));
                O(r,c,:)=I(sr,sc,:);
            else
                O(r,c,:)=I(r,c,:);
            end
        end
    end
end

function [sr,sc]=scord(SbI,SbDi,topR,topC,NFP) % output the position of min-distance point for points within SbI between some noise-free points within SbI 
rmin=realmax;
mr=0;
mc=0;
for r=1:size(SbI,1)
    for c=1:size(SbI,2)
        if SbDi(r,c)==1 % if is_noise(SbI(r,c))=true then ignore
            continue;
        end
        dt=fn.dst(SbI(r,c,:),estipx(SbI,SbDi,NFP)); % else then take into consideration
        if rmin>dt
           rmin=dt;
           mr=r;
           mc=c;
        end
    end
end
sr=mr+topR-1;
sc=mc+topC-1;
end

function [O]=estipx(SbI,SbDi,NFP) % get estimated pixel
        u=zeros(1,1,size(SbI,3));
        d=0;
        for i=1:length(NFP)
            Ip=SbI(NFP{i}(1),NFP{i}(2),:);
            al=alpha(SbI,SbDi,Ip);
            u=u+(al*Ip);
            d=d+al;
        end
        O=u/d;
end

function [O]=alpha(SbI,SbDi,Ip) 
c=0.006;
w=0.003;
B={c-w,c,c+w,c+(2*w),0.5};
S={w,w,w,w,0.5};
M={exp(-1),1,exp(-1),exp(-4),0};

u=0;
d=0;
for i=1:length(B)
    t=tk(SbI,SbDi,Ip,B{i},S{i});
    u=u+(t*M{i});
    d=d+t;
end
O=u/d;
end

function [O]=tk(SbI,SbDi,Ip,b,s)
u=(siml(SbI,SbDi,Ip)-b)^2;
d=2*((s)^2);
O=exp(u/d);
end

function [O]=siml(SbI,SbDi,Ip) % get ~similarity_value
[R,C]=fn.getsz(SbI);
MAXI=255;
s=0;
ct=0;
for r=1:R
    for c=1:C
        if SbDi(r,c)==1 % exclude noise points
            continue;
        end
        s=s+fn.dst(Ip,SbI(r,c,:));
        ct=ct+1;
    end
end
O=s/(3*MAXI*ct);
end

function [O]=Lvar(Di,r,c) % output min length of a window cnetered at (r,c) with some noise-free points within
[R,C]=fn.getsz(Di);
chk=0;
for L=3:2:min(R,C)
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
[R,C]=fn.getsz(SbDi);
pct=R*C-sum(SbDi(:));
O=cell(1,pct);
ct=0;
for r=1:R
   for c=1:C
       if SbDi(r,c)==0
           ct=ct+1;
           O{ct}=[r,c];
       end
   end
end
end

function [O]= DI(I) % get noise_tag_matrix with 1=noise_point,0=noise-free_point
[R,C,D]=fn.getsz(I);
O=zeros(R,C);
for j=1:D
    Ie=I(:,:,j);
    for i=1:R*C
       if Ie(i)==255||Ie(i)==0
            O(i)=1;
       end
    end
end
end
