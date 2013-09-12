function [ O,topR,topC ] = winsp( I,r,c,L ) 
Lh=(L-1)/2;
r1=r-Lh;
c1=c-Lh;
r2=r+Lh;
c2=c+Lh;
if ~(r1>=1&&c1>=1&&r2<=size(I,1)&&c2<=size(I,2))
    if r1<1
       r1=r1+abs(r1-1); 
    end
    if c1<1
       c1=c1+abs(c1-1); 
    end
    if r2>size(I,1)
       r2=r2-abs(r2-size(I,1));
    end
    if c2>size(I,2)
       c2=c2-abs(c2-size(I,2));
    end
end
O=I(r1:r2,c1:c2,:);
topR=r1;
topC=c1;
end

% [
% O = sub-Image with window_length L centered at (r,c)
% topR = row position of origin_image
% topC = column position of origin_image
% ]
% =winsp
% (
% I = input_image
% r = row pos. 
% c = col. pos.
% L = window_length
% )