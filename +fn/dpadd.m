function O=dpadd(I,L)
n=L-1;
[R,C,D]=fn.getsz(I);
O=zeros(length(n+1:R-n),length(n+1:C-n),D);
for i=1:D
O(:,:,i)=double(I(n+1:R-n,n+1:C-n,i));
end
end

% [
% O = de-pad a padded_image for window_length L 
% ]
% =dpadd
% (
% I = padded_image
% L = window_length
% )