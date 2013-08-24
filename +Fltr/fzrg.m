function [ O ] = fzrg( I )
wa=max(realmin,0.002*modeS(I)-0.005);

b={0,wa,2*wa,3*wa,(1+(3*wa))/2};
s={wa,wa,wa,wa,(1+(3*wa))/4};
m={1,3/4,1/2,1/4,0};
end

function [O]=modeS(I)

end