function O = avgfltr(I,L)
sz=size(I);
row=sz(1);
col=sz(2);
padl=L-1;
O=I;
    for j=1:3
        Ie=Fn.padd(I(:,:,j),padl);
        for r=(L+1)/2:row-((L-1)/2)+padl*2
            for c=(L+1)/2:col-((L-1)/2)+padl*2
                Ie(r,c)=sum(sum(Ie(r-((L-1)/2):r+((L-1)/2),c-((L-1)/2):c+((L-1)/2))))/(L*L);
            end
        end
        O(:,:,j)=Fn.dpadd(Ie,padl);
    end
end

