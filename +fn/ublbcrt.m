function [X]=ublbcrt(X,lbd,ubd)
X(X<=lbd)=lbd;
X(X>=ubd)=ubd;
end