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