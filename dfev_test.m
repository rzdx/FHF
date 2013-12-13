% rng('default');

fhd='cec13_func';
optsol=(-1400:100:1400);
optsol(15)=[];

iter=1;
bvtp=3;
evtp=28;

T=cell(bvtp,1);
bvnm={'rand','best','target-to-best'};
dif=zeros(iter,1);
rownm=cell(evtp,1);
colnm={'mean','std'};
datav=zeros(length(rownm),length(colnm));
for ibv=1:bvtp
    for iev=1:evtp
        for i=1:iter
            dif(i)=de.dfev(ibv,fhd,iev)...
                -optsol(iev);
        end
        rownm{iev}=['DE_cec2013_',bvnm{ibv},'-f',num2str(iev)];
        datav(iev,1)=mean(dif);
        datav(iev,2)=std(dif,1);
    end
    T{ibv}={datav,rownm,colnm};
end

% save('dfev_T.mat', 'T');
% XT={'dfev_T_xl.xls',0,T};
% tio.xlswt(XT);
