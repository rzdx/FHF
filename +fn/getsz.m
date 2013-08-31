function [R,C,D] = getsz(I)
   R=size(I,1);
   C=size(I,2);
   D=size(I,3);
end

% [
% R = number of rows of an image I
% C = number of col.s of an image I
% D = number of depths of an image I
% ]
% = getsz
% (
% I = input_image
% )

