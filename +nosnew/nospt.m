function [ O ] = nospt( R,C,p )
N=R*C;
Np=int32((p*N)/100);
nos=randperm(N);
O=nos(1:Np);
end