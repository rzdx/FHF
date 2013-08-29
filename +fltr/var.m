function [ O ] = var( I,L )
[R,C,D]=fn.getsz(I);
Lh=(L-1)/2;
ptg=ones(R,C,D);
Pdptg=fn.padd(ptg,L);
PdI=fn.padd(I,L);
PdO=zeros(size(PdI,1),size(PdI,2),size(PdI,3));
    for j=1:size(I,3)
        for r=1:R
            for c=1:C
                rr=r+Lh*2;
                cc=c+Lh*2;
                Ke=PdI(rr-Lh:rr+Lh,cc-Lh:cc+Lh,j);
                Pe=Pdptg(rr-Lh:rr+Lh,cc-Lh:cc+Lh,j);
                avg=sum(sum(Ke))/(sum(sum(Pe)));
                s=0;
                for k=1:L*L
                    if Pe(k)==0
                        continue;
                    end
                    s=s+((Ke(k)-avg))^2;
                end
                PdO(rr,cc,j)=s/(sum(sum(Pe)));
            end
        end
    end
    O=fn.dpadd(PdO,L);
end
