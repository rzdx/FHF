[PCN,I]=Pio.picrd({'lena_clr','histo_gry'});
O{1}=Nos.imp(I{1},10);
O{2}=Nos.gau(I{1},10);
O{3}=Nos.gau(I{2},10);
Fn.histo(I{2});
Fn.histo(O{3});
Pio.picshow(O);