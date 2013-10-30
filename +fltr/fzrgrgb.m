function [ O ] = fzrgrgb( I,par ) %fuzzy range filter
O(:,:,1) = fzrg(I(:,:,1), par);
O(:,:,2) = fzrg(I(:,:,2), par);
O(:,:,3) = fzrg(I(:,:,3), par);
end
