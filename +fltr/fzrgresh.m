function [ O ] = fzrgresh( I,par )
[m, n, c] = size(I);
Ic = reshape(I, m * n, c);
O = fltr.fzrg(Ic, par, m, n, c);
end