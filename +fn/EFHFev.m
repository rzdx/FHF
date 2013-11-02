function [ mse,OI ] = EFHFev( I,nI,vct,fltrtp )
switch fltrtp
    case 1 %nb
        OI=fltr.fznbresh(nI,vct);
    case 2 %rg
        OI=fltr.fzrgresh(nI,vct);
    case 3 %hy
        OI=fltr.fzhyresh(nI,vct);
    otherwise
        error('tag_undefined');
end
e=mean((I-OI).^2,3);
mse = mean(e(:));
end

