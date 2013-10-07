[PCN,I]=pio.picrd({'lena_clr','baboon_clr','pepper_clr'});
gauS=30;
fn.PSNR(I{3},nos.gau(I{3},gauS))
fn.PSNR(fltr.fzrg(nos.gau(I{3},gauS)),I{3})
% mixPS=15;
% miximg=nos.mix(I{1},mixPS,mixPS);
% a3=fltr.fzhy(miximg);
% O={a3};
% N={'a3'};
% pio.picshow(O);
% pio.picwtn(O,N);

% tio.tblshow(T);

% T=cell(1);
% z=zeros(2,2);
% r={'a_r1','z_r2'};
% c={'c1','c2'};
% t={z,r,c};
% T{1}=t;

% XT={'img_result.xls',0,T};
% tio.xlswt(XT);