function O = avg(I,L)
[R,C]=Fn.getsz(I);
padl=L-1;
Lh=(L-1)/2;
O=I;
    for j=1:size(I,3)
        Ie=Fn.padd(I(:,:,j),padl);
        for r=(L+1)/2:R-((L-1)/2)+padl*2
            for c=(L+1)/2:C-((L-1)/2)+padl*2
                Ie(r,c)=sum(sum(Ie(r-Lh:r+Lh,c-Lh:c+Lh)))/(L*L);
            end
        end
        O(:,:,j)=Fn.dpadd(Ie,padl);
    end
end

