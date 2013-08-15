function [ r,g,b ] = getrgb( I )
    r=double(I(:,:,1));
    g=double(I(:,:,2));
    b=double(I(:,:,3));
end

