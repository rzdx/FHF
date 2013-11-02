%rng('default');
if matlabpool('size')==0
    matlabpool('open');
end

[I,PCN]=pio.picrd({'lena_clr','baboon_clr','pepper_clr','lena_clr_64','lena_clr_128','lena_clr_256'});
nosct=6;
T=cell(1,6);
rn1={'PSNR_Noisy','PSNR_EFHF'};
rn2={'SSIM_Noisy','SSIM_EFHF'};
cn=cell(1,nosct);
PSNR_mat=zeros(2,nosct);
SSIM_mat=zeros(2,nosct);
PSNR_nos=zeros(1,nosct);
PSNR_EFHF=zeros(1,nosct);
SSIM_nos=zeros(1,nosct);
SSIM_EFHF=zeros(1,nosct);

for bsvct=1:1
    tic;
    pidx=1;
    impA=10;
    fltrtp=1;
    for ct=1:nosct
        cn{ct}=['imp:',num2str(ct*impA),'%'];
        impimg=nos.imp(I{pidx},ct*impA);
        fimpimg=fn.EFHFde(bsvct,I{pidx},impimg,fltrtp);
        PSNR_nos(ct)=fn.PSNR(I{pidx},impimg);
        PSNR_EFHF(ct)=fn.PSNR(I{pidx},fimpimg);
        SSIM_nos(ct)=fn.clrSSIM(I{pidx},impimg);
        SSIM_EFHF(ct)=fn.clrSSIM(I{pidx},fimpimg);
    end
    PSNR_mat(1,:)=PSNR_nos;
    PSNR_mat(2,:)=PSNR_EFHF;
    SSIM_mat(1,:)=SSIM_nos;
    SSIM_mat(2,:)=SSIM_EFHF;
    T{1}={PSNR_mat,rn1,cn};
    T{2}={SSIM_mat,rn2,cn};
    toc;
    
    tic;
    pidx=3;
    gauA=5;
    fltrtp=2;
    parfor ct=1:nosct
        cn{ct}=['gau:',num2str(ct*gauA)];
        gauimg=nos.gau(I{pidx},ct*gauA);
        fgauimg=fn.EFHFde(bsvct,I{pidx},gauimg,fltrtp);
        PSNR_nos(ct)=fn.PSNR(I{pidx},gauimg);
        PSNR_EFHF(ct)=fn.PSNR(I{pidx},fgauimg);
        SSIM_nos(ct)=fn.clrSSIM(I{pidx},gauimg);
        SSIM_EFHF(ct)=fn.clrSSIM(I{pidx},fgauimg);
    end
    PSNR_mat(1,:)=PSNR_nos;
    PSNR_mat(2,:)=PSNR_EFHF;
    SSIM_mat(1,:)=SSIM_nos;
    SSIM_mat(2,:)=SSIM_EFHF;
    T{3}={PSNR_mat,rn1,cn};
    T{4}={SSIM_mat,rn2,cn};
    toc;
    
    tic;
    pidx=1;
    mixA=5;
    fltrtp=3;
    parfor ct=1:nosct
        cn{ct}=['mix:',num2str(mixA*ct),'%/',num2str(mixA*ct)];
        miximg=nos.mix(I{1},mixA*ct,mixA*ct);
        fmiximg=fn.EFHFde(bsvct,I{pidx},miximg,fltrtp);
        PSNR_nos(ct)=fn.PSNR(I{pidx},miximg);
        PSNR_EFHF(ct)=fn.PSNR(I{pidx},fmiximg);
        SSIM_nos(ct)=fn.clrSSIM(I{pidx},miximg);
        SSIM_EFHF(ct)=fn.clrSSIM(I{pidx},fmiximg);
    end
    PSNR_mat(1,:)=PSNR_nos;
    PSNR_mat(2,:)=PSNR_EFHF;
    SSIM_mat(1,:)=SSIM_nos;
    SSIM_mat(2,:)=SSIM_EFHF;
    T{5}={PSNR_mat,rn1,cn};
    T{6}={SSIM_mat,rn2,cn};
    toc;
    
    %     -----------------------------------------------pic_output
    %
    %     N={'impimg','fimpimg','gauimg','fgauimg','miximg','fmiximg'};
    %     O={impimg,fimpimg,gauimg,fgauimg,miximg,fmiximg};
    %     pio.picshow(O);
    %     pio.picwtn(O,N);
    %
    %     -----------------------------------------------table_output
    %
    %     save('img_T.mat', 'T');
    tio.tblshow(T);
end