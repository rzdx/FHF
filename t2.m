[I]=pio.picrd({'lena_clr_s128','baboon_clr','pepper_clr'});
% gauS=30;
impA=60;
pidx=1;
% P=nos.gau(I{pidx},gauS);
P=nos.imp(I{pidx},impA);
% fn.PSNR(I{pidx},P)
% fn.PSNR(fltr.fzrg(P),I{pidx})
tic;
% F=fltr.fzrgresh(P,0);
F=fltr.fznbresh(P,0);
% fn.PSNR(I{pidx},F)
toc;
O={F};
% mixPS=15;
% miximg=nos.mix(I{1},mixPS,mixPS);
% a3=fltr.fzhy(miximg);
% O={a3};
% N={'a3'};
pio.picshow(O);
% pio.picwtn(O,N);
