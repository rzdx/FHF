[PCN,I]=Pio.picrd({'lena_clr'});
%O{1}=Nos.imp(I{1},10);
%O{2}=Nos.gau(I{1},10);
%O{3}=Nos.mix(I{1},10,10);

O=Fltr.var([1 1 1;1 1 1;1 1 1],3);

%Pio.picshow(O);