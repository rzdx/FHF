%rng('default');
iter=30;
bvtp=3;
evtp=24;
fzN=5;

T=cell(bvtp,1);
bvnm={'rand','best','target-to-best'};
dif=zeros(iter,1);
rownm=cell(evtp,1);
colnm={'mean','std'};
datav=zeros(length(rownm),length(colnm));
for ibv=1:bvtp
    for iev=1:evtp
        for i=1:iter
            dif(i)=fn.dfev(fzN,ibv,['bbob2012.bbob12_f',num2str(iev)])...
                -feval(['bbob2012.bbob12_f',num2str(iev)],'xopt');
        end
        rownm{iev}=[bvnm{ibv},'_bbob12_f',num2str(iev)];
        datav(iev,1)=mean(dif);
        datav(iev,2)=std(dif,1);
    end
    T{ibv}={datav,rownm,colnm};
end

save('dfev_T.mat', 'T');
%tio.tblshow(T);
