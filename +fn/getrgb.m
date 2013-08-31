function [ r,g,b ] = getrgb( I )
    r=double(I(:,:,1));
    g=double(I(:,:,2));
    b=double(I(:,:,3));
end

% [
% r = an image of channel red of an input_image
% g = an image of channel green of an input_image
% b = an image of channel blue of an input_image
% ]
% = getrgb
% (
% I = input_image
% )