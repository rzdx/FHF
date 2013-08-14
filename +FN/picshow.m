function picshow(O)
for i=1:length(O)
    figure;
    imshow(uint8(O{i}));
end
end