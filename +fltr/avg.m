function O = avg(I,L)
[R,C]=fn.getsz(I);
Lh=(L-1)/2;
Ie=fn.padd(I,L);
Iavg=zeros(size(Ie,1),size(Ie,2),size(Ie,3));
    for j=1:size(Ie,3)
        for r=1:R
            for c=1:C
                rr=r+Lh*2;
                cc=c+Lh*2;
                Iavg(rr,cc,j)=sum(sum(Ie(rr-Lh:rr+Lh,cc-Lh:cc+Lh,j)))/(L*L);
            end
        end
    end
O=fn.dpadd(Iavg,L);
end