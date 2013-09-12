function [ O ] = PSNR(I1,I2)
e=mean((I1-I2).^2,3);
mse = mean(e(:));
O=10*log10((255^2/mse));
end

