%rng('default');
[PCN,I]=pio.picrd({'lena_clr','baboon_clr','pepper_clr'});

I10=nos.imp(I{1},10);
fI10=fltr.fznb(I10);
imp10_PSNR=fn.PSNR(I{1},I10)
imp10_fznb_PSNR=fn.PSNR(I{1},fI10)
z1=zeros(1,3);
z2=zeros(1,3);
for i=1:length(z1)
    z1(i)=fn.SSIM2(I{1}(:,:,i),I10(:,:,i));
    z2(i)=fn.SSIM2(I{1}(:,:,i),fI10(:,:,i));
end
imp10_SSIM=mean(z1)
imp10_fznb_SSIM=mean(z2)

G10=nos.gau(I{3},10);
fG10=fltr.fzrg(G10);
gau10_PSNR=fn.PSNR(I{3},G10)
gau10_fzrg_PSNR=fn.PSNR(I{3},fG10)
z1=zeros(1,3);
z2=zeros(1,3);
for i=1:length(z)
    z1(i)=fn.SSIM2(I{3}(:,:,i),G10(:,:,i));
    z2(i)=fn.SSIM2(I{3}(:,:,i),fG10(:,:,i));
end
gau10_SSIM=mean(z1)
gau10_fzrg_SSIM=mean(z2)

N1010=nos.mix(I{1},10,10);
fN1010=fltr.fzhy(N1010);
mix1010_PSNR=fn.PSNR(I{1},N1010)
mix1010_fzhy_PSNR=fn.PSNR(I{1},fN1010)
z1=zeros(1,3);
z2=zeros(1,3);
for i=1:length(z)
    z1(i)=fn.SSIM2(I{1}(:,:,i),N1010(:,:,i));
    z2(i)=fn.SSIM2(I{1}(:,:,i),fN1010(:,:,i));
end
mix1010_SSIM=mean(z1)
mix1010_fzhy_SSIM=mean(z2)

%-----------------------------------------------

O={I10,fI10,G10,fG10,N1010,fN1010};
pio.picshow(O);
