function picwtn(I,ns)
for i=1:length(I)
    imwrite(uint8(I{i}),[ns{i},'.bmp']);
end
end

% write images with output file_name ns.bmp
% picwtn
% (
% I = input_images
% ns = names
% )