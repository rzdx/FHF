function O=dpadd(I,L)
n=L-1;
sz=size(I);
row=sz(1);
col=sz(2);
O=double(I(n+1:row-n,n+1:col-n));
end