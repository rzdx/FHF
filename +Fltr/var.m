function [ O ] = var( I,L )
[R,C]=Fn.getsz(I);
padl=L-1;
Lh=(L-1)/2;
O=I;
    for j=1:size(I,3)
        Ie=Fn.padd(I(:,:,j),L);
        Oe=Ie;
        for r=(L+1)/2:R-((L-1)/2)+padl*2
            for c=(L+1)/2:C-((L-1)/2)+padl*2
                Ke=Ie(r-Lh:r+Lh,c-Lh:c+Lh);
                avg=sum(sum(Ke))/(L*L);
                sm=0;
                for k=1:L*L
                    sm=sm+((Ke(k)-avg))^2;
                end
                Oe(r,c)=sm/((L*L)-1);
            end
        end
        O(:,:,j)=Fn.dpadd(Oe,L);
    end
end
