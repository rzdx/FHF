function picwt(O,str)
for i=1:length(O)
    imwrite(uint8(O{i}),[str,num2str(i),'.bmp']);
end
end