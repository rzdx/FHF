function [ O ] = var( I,L )
Lh=(L-1)/2;
ptg=ones(size(I,1),size(I,2),size(I,3));
Pdptg=fn.padd(ptg,L);
PdI=fn.padd(I,L);
PdO=zeros(size(PdI,1),size(PdI,2),size(PdI,3));
    for j=1:size(I,3)
        for r=1:size(I,1)
            for c=1:size(I,2)
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

% [
% O = a matrix of variance of points in a window with window_length L centered at each position in an input_image I
% ]
% =var
% (
% I = input_image
% L = window_length
% )