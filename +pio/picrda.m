function [picn,I,w,h,r,g,b]=picrda(inpic)
picn=length(inpic);
I=cell(picn);
sz=cell(picn);
w=cell(picn);
h=cell(picn);
r=cell(picn);
g=cell(picn);
b=cell(picn);
for i=1:length(inpic)
    inpic{i}=['\+PIC\',inpic{i},'.bmp'];
    I{i}=imread(inpic{i});
    sz{i}=size(I{i});
    w{i}=sz{i}(1);
    h{i}=sz{i}(2);
    r{i}=double(I{i}(:,:,1));
    g{i}=double(I{i}(:,:,2));
    b{i}=double(I{i}(:,:,3));
end
end

% read out all input_image's info.
% [
% picn = number of images read in
% I = read_images
% w = widths 
% h = heights
% r = red_images
% g = green_images
% b = blue_images
% ]
% =picrda (color image only)
% (
% inpic = input_image_filepaths
% )