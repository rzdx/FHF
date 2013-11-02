%rng('default');
if matlabpool('size')==0
	matlabpool('open');
end

[I,PCN]=pio.picrd({'lena_clr','baboon_clr','pepper_clr','lena_clr_64','lena_clr_128','lena_clr_256'});
nosct=6;
T=cell(1,6);
rn1={'PSNR_Noisy','PSNR_FHF'};
rn2={'SSIM_Noisy','SSIM_FHF'};
cn=cell(1,nosct);
PSNR_mat=zeros(2,nosct);
SSIM_mat=zeros(2,nosct);
PSNR_nos=zeros(1,nosct);
PSNR_FHF=zeros(1,nosct);
SSIM_nos=zeros(1,nosct);
SSIM_FHF=zeros(1,nosct);

tic;
pidx=1;
impA=10;
for ct=1:nosct
    cn{ct}=['imp:',num2str(ct*impA),'%'];
    impimg=nos.imp(I{pidx},ct*impA);
    fimpimg=fltr.fznbresh(impimg,0);
    PSNR_nos(ct)=fn.PSNR(I{pidx},impimg);
    PSNR_FHF(ct)=fn.PSNR(I{pidx},fimpimg);
    SSIM_nos(ct)=fn.clrSSIM(I{pidx},impimg);
    SSIM_FHF(ct)=fn.clrSSIM(I{pidx},fimpimg);
end
PSNR_mat(1,:)=PSNR_nos;
PSNR_mat(2,:)=PSNR_FHF;
SSIM_mat(1,:)=SSIM_nos;
SSIM_mat(2,:)=SSIM_FHF;
T{1}={PSNR_mat,rn1,cn};
T{2}={SSIM_mat,rn2,cn};
toc;

tic;
pidx=3;
gauA=5;
parfor ct=1:nosct
    cn{ct}=['gau:',num2str(ct*gauA)];
    gauimg=nos.gau(I{pidx},ct*gauA);
    fgauimg=fltr.fzrgresh(gauimg,0);
    PSNR_nos(ct)=fn.PSNR(I{pidx},gauimg);
    PSNR_FHF(ct)=fn.PSNR(I{pidx},fgauimg);
    SSIM_nos(ct)=fn.clrSSIM(I{pidx},gauimg);
    SSIM_FHF(ct)=fn.clrSSIM(I{pidx},fgauimg);
end
PSNR_mat(1,:)=PSNR_nos;
PSNR_mat(2,:)=PSNR_FHF;
SSIM_mat(1,:)=SSIM_nos;
SSIM_mat(2,:)=SSIM_FHF;
T{3}={PSNR_mat,rn1,cn};
T{4}={SSIM_mat,rn2,cn};
toc;

tic;
pidx=1;
mixA=5;
parfor ct=1:nosct
    cn{ct}=['mix:',num2str(mixA*ct),'%/',num2str(mixA*ct)];
    miximg=nos.mix(I{pidx},mixA*ct,mixA*ct);
    fmiximg=fltr.fzhyresh(miximg,0);
    PSNR_nos(ct)=fn.PSNR(I{pidx},miximg);
    PSNR_FHF(ct)=fn.PSNR(I{pidx},fmiximg);
    SSIM_nos(ct)=fn.clrSSIM(I{pidx},miximg);
    SSIM_FHF(ct)=fn.clrSSIM(I{pidx},fmiximg);
end
PSNR_mat(1,:)=PSNR_nos;
PSNR_mat(2,:)=PSNR_FHF;
SSIM_mat(1,:)=SSIM_nos;
SSIM_mat(2,:)=SSIM_FHF;
T{5}={PSNR_mat,rn1,cn};
T{6}={SSIM_mat,rn2,cn};
toc;

%-----------------------------------------------pic_output

% N={'impimg','fimpimg','gauimg','fgauimg','miximg','fmiximg'};
% O={impimg,fimpimg,gauimg,fgauimg,miximg,fmiximg};
% pio.picshow(O);
% pio.picwtn(O,N);

%-----------------------------------------------table_output

% save('img_T.mat', 'T');
tio.tblshow(T);