rng('default');
[PCN,I]=pio.picrd({'baboon_clr'});

N1515=nos.mix(I{1},15,15);

% N15=fltr.fznb(N1515);
% O={N1515,N15};

N15=fltr.fznb(N1515);
fnl=fltr.fzrg(N15);
O={N1515,N15,fnl};

%N1515=nos.mix(I{1},15,15);
% fnl=fltr.fzhy(N1515);
% O={fnl};

pio.picshow(O);