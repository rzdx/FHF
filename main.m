[PCN,I]=Pio.picrd({'lena_clr'});
[R,C]=Fn.getsz(I{1}(:,:,1));
[RED,GRN,BLU]=Fn.getrgb(I{1});
O{1}=Nos.imp(I{1},50);
Pio.picshow(O);