function [ O ] = fznbresh( I,par )
[m, n, c] = size(I);
Ic = reshape(I, m * n, c);
O = fltr.fznb(Ic, par, m, n, c);
end