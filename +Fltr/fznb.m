function [ O ] = fznb( I )
c=0.006;
w=0.003;
b={c-w,c,c+w,c+(2*w),0.5};
s={w,w,w,w,0.5};
m={exp(-1),1,exp(-1),exp(-4),0};

di=DI(I);
[Lm,nfp]=Lvar(di);

% O=Y(I,di);
end

% function [O]=Y(I,Di)
% [R,C]=Fn.getsz(I);
% O=zeros(R,C,size(I,3));
% Lm=Lvar(Di);
% for j=1:size(I,3)
%     Ie=I(:,:,j);
%     Oe=zeros(R,C);
%     for r=1:R
%         for c=1:C
%            if Di(r,c)==1
%                [sr,sc]=scord();
%                Oe(r,c)=Ie(sr,sc);
%            else
%                Oe(r,c)=Ie(r,c);
%            end
%         end
%        
%     end
%     O(:,:,j)=Oe;
% end
% end

function [sr,sc]=scord(SbPdI,centR,centC,L)
I=SbPdI;
Ln=(L+1)/2;
ep=estipx(centR,centC);
min=realmax;
for r=1:L
    for c=1:L
        if min>Fn.dst(I(r,c,:),ep);
           min=Fn.dst(I(r,c,:),ep);
           mr=r;
           mc=c;
        end
    end
end
sr=mr-Ln+centR;
sc=mc-Ln+centC;
end

function [O]=estipx(centR,centC)

end

function [O,P]=Lvar(Di)
[R,C]=Fn.getsz(Di);
O=zeros(R,C);
P=cell(R,C);
for r=1:R
    for c=1:C
        chk=0;
        for L=3:2:min(R,C)
            Lh=(L-1)/2;
            Ie=Fn.padd1(Di,L);
            rr=r+Lh*2;
            cc=c+Lh*2;
            if sum(sum(Ie(rr-Lh:rr+Lh,cc-Lh:cc+Lh)))~=L*L
                chk=1;
                break;
            end
        end
        if chk
            O(r,c)=L;
            P{r,c}=getnzfp(Ie(rr-Lh:rr+Lh,cc-Lh:cc+Lh),r,c,L);
        else
            error('L out_of_bound')
        end
    end
end
end

function [O]=getnzfp(SbPdDi,centR,centC,L)
I=SbPdDi;
Ln=(L+1)/2;
ct=0;
for r=1:L
   for c=1:L
       if I(r,c)==0
           ct=ct+1;
           O{ct}=[r-Ln+centR,c-Ln+centC];
       end
   end
end
end

function [O]= DI(I)
[R,C]=Fn.getsz(I);
O=zeros(R,C);
for j=1:size(I,3)
    Ie=I(:,:,j);
    for i=1:R*C
       if Ie(i)==255||Ie(i)==0
            O(i)=1;
       end
    end
end
end
