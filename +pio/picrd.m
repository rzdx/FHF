function [picn,I]=picrd(inpic)
picn=length(inpic);
I=cell(picn);
for i=1:length(inpic)
    inpic{i}=['\+PIC\',inpic{i},'.bmp'];
    I{i}=double(imread(inpic{i}));
end

end