function O=dpadd(I,L)
n=L-1;
[R,C]=Fn.getsz(I);
D=size(I,3);
O=zeros(length(n+1:R-n),length(n+1:C-n),D);
for i=1:D
O(:,:,i)=double(I(n+1:R-n,n+1:C-n,i));
end
end