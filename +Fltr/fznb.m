function [ O ] = fznb( I )
c=0.006;
w=0.003;
b={c-w,c,c+w,c+(2*w),0.5};
s={w,w,w,w,0.5};
m={exp(-1),1,exp(-1),exp(-4),0};



end

function [O]=Y(I,Di)
[R,C]=Fn.getsz(I);
O=zeros(R,C,size(I,3));
L=Lvar(I);
padl=L-1;
Lh=(L-1)/2;
for j=1:size(I,3)
    Ie=I(:,:,j);
    Oe=zeros(R,C);
    for r=1:R
        for c=1:C
           if Di(r,c)==1&&sum(sum(Di(r-Lh:r+Lh,c-Lh:c+Lh)))<L*L
           Oe(r,c)=X();
           else
           Oe(r,c)=Ie(r,c);
           end
        end
       
    end
    O(:,:,j)=Oe;
end
end

function [L]=Lvar(I)
L=3;

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


