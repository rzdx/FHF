%rng('default');
if matlabpool('size')==0
    matlabpool('open');
end

[I,PCN]=pio.picrd({'lena_clr','baboon_clr','pepper_clr','lena_clr_64','lena_clr_128','lena_clr_256'});
nosct=6;
T=cell(1,6);
paraT=zeros(15,6,3);
rn1={'PSNR_Noisy','PSNR_EFHF'};
rn2={'SSIM_Noisy','SSIM_EFHF'};
cn=cell(1,nosct);
PSNR_mat=zeros(2,nosct);
SSIM_mat=zeros(2,nosct);
PSNR_nos=zeros(1,nosct);
PSNR_EFHF=zeros(1,nosct);
SSIM_nos=zeros(1,nosct);
SSIM_EFHF=zeros(1,nosct);

allpidx=1;

for bsvct=1:3
    tic;
    pidx=allpidx;
    impA=10;
    fltrtp=1;
    for ct=1:nosct
        cn{ct}=['imp:',num2str(ct*impA),'%'];
        impimg=nos.imp(I{pidx},ct*impA);
        [fimpimg,para]=fn.EFHFde(bsvct,I{pidx},impimg,fltrtp);
        paraT(:,ct,fltrtp)=para;
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
    pidx=allpidx;
    gauA=5;
    fltrtp=2;
    parfor ct=1:nosct
        cn{ct}=['gau:',num2str(ct*gauA)];
        gauimg=nos.gau(I{pidx},ct*gauA);
        [fgauimg,para]=fn.EFHFde(bsvct,I{pidx},gauimg,fltrtp);
        paraT(:,ct,fltrtp)=para;
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
    
    hyiparaT=zeros(15,6);
    hygparaT=zeros(15,6);
    
    tic;
    pidx=allpidx;
    mixA=5;
    parfor ct=1:nosct
        cn{ct}=['mix:',num2str(mixA*ct),'%/',num2str(mixA*ct)];
        miximg=nos.mix(I{pidx},mixA*ct,mixA*ct);
        [fimiximg,para]=fn.EFHFde(bsvct,I{pidx},miximg,1);
        hyiparaT(:,ct)=para;
        [fmiximg,para]=fn.EFHFde(bsvct,I{pidx},fimiximg,2);
        hygparaT(:,ct)=para;
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
    
    %         -----------------------------------------------pic_output
    %
    %         N={'impimg','fimpimg','gauimg','fgauimg','miximg','fmiximg'};
    %         O={impimg,fimpimg,gauimg,fgauimg,miximg,fmiximg};
    %         pio.picshow(O);
    %         pio.picwtn(O,N);
    %
    %         -----------------------------------------------table_output

    %     save(['img_T-',num2str(bsvct),'.mat'], 'T');
    %     save(['para_T-',num2str(bsvct),'.mat'], 'paraT');
    %     save(['hyiparaT-',num2str(bsvct),'.mat'], 'hyiparaT');
    %     save(['hygparaT-',num2str(bsvct),'.mat'], 'hygparaT');
    tio.tblshow(T);
end