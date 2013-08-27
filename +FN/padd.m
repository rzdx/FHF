function O=padd(I,L)
n=L-1;
sz=size(I);
row=sz(1);
col=sz(2);
spad=zeros(n,n);
rpad=zeros(row,n);
cpad=zeros(n,col);
O=double([spad,cpad,spad;rpad,I,rpad;spad,cpad,spad]);
end