function [ O,topR,topC ] = winsp( I,r,c,L ) 
[R,C]=fn.getsz(I);
Lh=(L-1)/2;
r1=r-Lh;
c1=c-Lh;
r2=r+Lh;
c2=c+Lh;
if ~(r1>=1&&c1>=1&&r2<=R&&c2<=C)
    if r1<1
       r1=r1+abs(r1-1); 
    end
    if c1<1
       c1=c1+abs(c1-1); 
    end
    if r2>R
       r2=r2-abs(r2-R);
    end
    if c2>C
       c2=c2-abs(c2-C);
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