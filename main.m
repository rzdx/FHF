[PCN,I]=Pio.picrd({'lena_clr'});
%O{1}=Nos.imp(I{1},10);
%O{2}=Nos.gau(I{1},10);
%O{3}=Nos.mix(I{1},10,10);

%O{1}=Fltr.fznb(Nos.imp(I{1},10));
%tt=[1,0,0,0,1;0,0,0,0,0;0,0,1,0,0;0,0,0,0,0;1,0,0,0,1]
O{1}=Fltr.fznb(Nos.imp(I{1},10));
Pio.picshow(O);