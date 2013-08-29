[PCN,I]=pio.picrd({'lena_clr'});
O{1}=nos.mix(I{1},15,15);
O{2}=fltr.fzhy(O{1});
pio.picshow(O);