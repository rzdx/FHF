function O=padd1(I,n)
sz=size(I);
row=sz(1);
col=sz(2);
spad=ones(n,n);
rpad=ones(row,n);
cpad=ones(n,col);
O=double([spad,cpad,spad;rpad,I,rpad;spad,cpad,spad]);
end