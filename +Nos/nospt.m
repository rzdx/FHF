function [ nosp ] = nospt( R,C,p )
N=R*C;
Np=int32((p*N)/100);
nos=randperm(N);
nosp=nos(1:Np);
end