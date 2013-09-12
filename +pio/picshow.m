function picshow(I)
for i=1:length(I)
    figure(i);
    imshow(uint8(I{i}));
end
end

% show images
% picshow
% (
% I = input_images
% )