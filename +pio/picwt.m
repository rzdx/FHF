function picwt(I,str)
for i=1:length(I)
    imwrite(uint8(I{i}),[str,num2str(i),'.bmp']);
end
end

% write images with output file_name str#.bmp
% picwt
% (
% I = input_images
% str = name
% )