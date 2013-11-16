function [ O ] = mix( I,S,p )
O=nos.imp(nos.gau(I,S),p);
end
