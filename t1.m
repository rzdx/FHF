[PCN,I]=pio.picrd({'lena_clr','baboon_clr','pepper_clr'});
gauS=30;
pidx=1;
P=nos.gau(I{pidx},gauS);
fn.PSNR(I{pidx},P)
fn.PSNR(fltr.fzrg(P),I{pidx})
% mixPS=15;
% miximg=nos.mix(I{1},mixPS,mixPS);
% a3=fltr.fzhy(miximg);
% O={a3};
% N={'a3'};
% pio.picshow(O);
% pio.picwtn(O,N);
