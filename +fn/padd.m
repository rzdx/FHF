function O=padd(I,L)
n=L-1;
[R,C,D]=fn.getsz(I);
spad=zeros(n,n);
rpad=zeros(R,n);
cpad=zeros(n,C);
O=zeros(length([spad;rpad;spad]),length([spad,cpad,spad]),D);
for i=1:D
O(:,:,i)=double([spad,cpad,spad;rpad,I(:,:,i),rpad;spad,cpad,spad]);
end
end

% [
% O = pad an image used for window_length L with 0
% ]
% = padd1
% ( 
% I = input_image
% L = window_length
% )