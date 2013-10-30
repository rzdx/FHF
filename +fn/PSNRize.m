function [ O ] = PSNRize( mse )
O=10*log10((255^2/mse));
end