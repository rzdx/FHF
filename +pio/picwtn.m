function picwtn(O,ns)
for i=1:length(O)
    imwrite(uint8(O{i}),[ns{i},'.bmp']);
end
end