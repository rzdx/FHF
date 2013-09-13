function [ O ] = clrSSIM(I1,I2)
z=zeros(1,size(I1,3));
for i=1:length(z)
    z(i)=fn.SSIM2(I1(:,:,i),I2(:,:,i));
end
O=mean(z);
end
