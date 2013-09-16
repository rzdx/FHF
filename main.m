%rng('default');
[PCN,I]=pio.picrd({'lena_clr','baboon_clr','pepper_clr'});
nosct=6;
T=cell(1,6);

rn1={'PSNR_Noisy','PSNR_FHF'};
rn2={'SSIM_Noisy','SSIM_FHF'};
cn=cell(1,nosct);

impA=10;
impmat_PSNR=zeros(2,nosct);
impmat_SSIM=zeros(2,nosct);
ct=0;
for impP=impA:impA:impA*nosct
    ct=ct+1;
    cn{ct}=['imp:',num2str(impP),'%'];
    impimg=nos.imp(I{1},impP);
    fimpimg=fltr.fznb(impimg);
    impmat_PSNR(1,ct)=fn.PSNR(I{1},impimg);
    impmat_PSNR(2,ct)=fn.PSNR(I{1},fimpimg);
    impmat_SSIM(1,ct)=fn.clrSSIM(I{1},impimg);
    impmat_SSIM(2,ct)=fn.clrSSIM(I{1},fimpimg);
end
T{1}={impmat_PSNR,rn1,cn};
T{2}={impmat_SSIM,rn2,cn};

gauA=5;
gaumat_PSNR=zeros(2,nosct);
gaumat_SSIM=zeros(2,nosct);
ct=0;
for gauS=gauA:gauA:gauA*nosct
    ct=ct+1;
    cn{ct}=['gau:',num2str(gauS)];
    gauimg=nos.gau(I{3},gauS);
    fgauimg=fltr.fzrg(gauimg);
    gaumat_PSNR(1,ct)=fn.PSNR(I{3},gauimg);
    gaumat_PSNR(2,ct)=fn.PSNR(I{3},fgauimg);
    gaumat_SSIM(1,ct)=fn.clrSSIM(I{3},gauimg);
    gaumat_SSIM(2,ct)=fn.clrSSIM(I{3},fgauimg);
end
T{3}={gaumat_PSNR,rn1,cn};
T{4}={gaumat_SSIM,rn2,cn};

mixA=5;
mixmat_PSNR=zeros(2,nosct);
mixmat_SSIM=zeros(2,nosct);
ct=0;
for mixPS=mixA:mixA:mixA*nosct
    ct=ct+1;
    cn{ct}=['mix:',num2str(mixPS),'%/',num2str(mixPS)];
    miximg=nos.mix(I{1},mixPS,mixPS);
    fmiximg=fltr.fzhy(miximg);
    mixmat_PSNR(1,ct)=fn.PSNR(I{1},miximg);
    mixmat_PSNR(2,ct)=fn.PSNR(I{1},fmiximg);
    mixmat_SSIM(1,ct)=fn.clrSSIM(I{1},miximg);
    mixmat_SSIM(2,ct)=fn.clrSSIM(I{1},fmiximg);
end
T{5}={mixmat_PSNR,rn1,cn};
T{6}={mixmat_SSIM,rn2,cn};

%-----------------------------------------------pic_output

% O={};
% pio.picshow(O);

%-----------------------------------------------table_output

save('tables.mat', 'T');
tio.tblshow(T);
