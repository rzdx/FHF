function [ O ] = fznb( I )
di=DI(I);
O=Y(I,di);
end

function [O]=Y(I,Di)
[R,C,D]=fn.getsz(I);
O=zeros(R,C,D);
padtag=ones(R,C);
%nosleft=sum(sum(Di));
    for r=1:R
        for c=1:C
            if Di(r,c)==1
                
                %nosleft=nosleft-1

                L=Lvar(Di,r,c);
                PdDi=fn.padd1(Di,L);
                PdI=fn.padd(I,L);
                Pdpadtag=fn.padd(padtag,L);
                Lh=(L-1)/2;
                rr=r+Lh*2;
                cc=c+Lh*2;
                SbPdDi=PdDi(rr-Lh:rr+Lh,cc-Lh:cc+Lh);
                iSbPdDi=fn.zotrans(SbPdDi);
                SbPdI=PdI(rr-Lh:rr+Lh,cc-Lh:cc+Lh,:);
                SbPdpadtag=Pdpadtag(rr-Lh:rr+Lh,cc-Lh:cc+Lh).*iSbPdDi;
                [sr,sc]=scord(SbPdI,rr,cc,L,getnzfp(SbPdDi,L),SbPdpadtag);
                O(r,c,:)=I(sr-(Lh*2),sc-(Lh*2),:);
            else
                O(r,c,:)=I(r,c,:);
            end
        end
    end
end

function [sr,sc]=scord(SbPdI,centR,centC,L,NFP,SbPdpadtag) % output padded cord.
Ln=(L+1)/2;
rmin=realmax;
mr=0;
mc=0;
for r=1:L
    for c=1:L
        if SbPdpadtag(r,c)==0
            continue;
        end
        dt=fn.dst(SbPdI(r,c,:),estipx(SbPdI,NFP,L,SbPdpadtag));
        if rmin>dt
           rmin=dt;
           mr=r;
           mc=c;
        end
    end
end
sr=mr-Ln+centR;
sc=mc-Ln+centC;
end

function [O]=estipx(SbPdI,NFP,L,SbPdpadtag)
        u=zeros(1,1,size(SbPdI,3));
        d=0;
        for i=1:max(size(NFP))
            Ip=SbPdI(NFP{i}(1),NFP{i}(2),:);
            al=alf(SbPdI,Ip,L,SbPdpadtag);
            u=u+(al*Ip);
            d=d+al;
        end
        O=u/d;
end

function [O]=alf(SbPdI,Ip,L,SbPdpadtag)
c=0.006;
w=0.003;
B={c-w,c,c+w,c+(2*w),0.5};
S={w,w,w,w,0.5};
M={exp(-1),1,exp(-1),exp(-4),0};

u=0;
d=0;
for i=1:length(B)
    t=tk(SbPdI,Ip,L,B{i},S{i},SbPdpadtag);
    u=u+(t*M{i});
    d=d+t;
end
O=u/d;
end

function [O]=tk(SbPdI,Ip,L,b,s,SbPdpadtag)
u=(siml(SbPdI,Ip,L,SbPdpadtag)-b)^2;
d=2*((s)^2);
O=exp(u/d);
end

function [O]=siml(SbPdI,Ip,L,SbPdpadtag) %Ip=I(NFPcordR,NFPcordC,:)
MAXI=255;
s=0;
ct=0;
for r=1:L
    for c=1:L
        if SbPdpadtag(r,c)==0
            continue;
        end
        s=s+fn.dst(Ip,SbPdI(r,c,:));
        ct=ct+1;
    end
end
O=s/(3*MAXI*ct);
end

function [O]=Lvar(Di,r,c)
[R,C]=fn.getsz(Di);
chk=0;
        for L=3:2:min(R,C)
            Lh=(L-1)/2;
            Ie=fn.padd1(Di,L);
            rr=r+Lh*2;
            cc=c+Lh*2;
            if sum(sum(Ie(rr-Lh:rr+Lh,cc-Lh:cc+Lh)))~=L*L
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

function [O]=getnzfp(SbPdDi,L) % output local cord.
pct=L*L-sum(sum(SbPdDi));
O=cell(1,pct);
ct=0;
for r=1:L
   for c=1:L
       if SbPdDi(r,c)==0
           ct=ct+1;
           O{ct}=[r,c];
       end
   end
end
end

function [O]= DI(I)
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
