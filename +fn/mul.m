function [O]=mul(I)
O=I(1);
for i=2:max(size(I))
    O=O*I(i);
end
end