function [ mse ] = EFHFev( I,nI,vct,tag )
par=cell(3,1);
for i=1:3
    par{i}=vct(1+(i-1)*5:i*5);
end
switch tag
    case 1 %nb
        OI=fltr.fznb(nI,par);
    case 2 %rg
        OI=fltr.fzrg(nI,par);
    case 3 %hy
        OI=fltr.fzhy(nI,par);
    otherwise
        error('tag_undefined');
end
e=mean((I-OI).^2,3);
mse = mean(e(:));
end

