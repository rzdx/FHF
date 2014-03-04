mpool
%% folder setting
topicnm='';
fldn=[topicnm,'result'];
sfldn={'meanstd','boxplot','contour','convergence','ranksum'};
fio.nfolds(fldn,sfldn);
%% output pic. setting
ptfnm='.png';
%% fun. eval. setting
d=10;
funmin=1;
funmax=28;
runmax=10;
funlen=funmax-funmin+1;

fhd='cec13_func';
optsol=(-1400:100:1400);
optsol(15)=[];

runrst=zeros(runmax,funlen);
minvrst=cell(runmax,funlen);
meanvrst=minvrst;
%% meanstd
tic;

rownm=cell(funlen,1);
colnm={'mean','std','success_rate'};
datav=zeros(length(rownm),length(colnm));
dr=0;
for fn=funmin:funmax
    tmsv=zeros(runmax,1);
    parfor rn=1:runmax
        [cmaminv,cmaminpara,cmagminv,cmagmeanv]=de.cmaev(d,fhd,fn);
        tmsv(rn)=cmaminv-optsol(fn);
        minvrst{rn,fn}=cmagminv-optsol(fn);
        meanvrst{rn,fn}=cmagmeanv-optsol(fn);
    end
    tmsv(tmsv<1e-8)=0;
    mn=mean(tmsv);
    sd=std(tmsv,1);
    mn(mn<1e-8)=0;
    sd(sd<1e-8)=0;
    
    dr=dr+1;
    runrst(:,dr)=tmsv;
    datav(dr,1)=mn;
    datav(dr,2)=sd;
    datav(dr,3)=length(tmsv(tmsv<1e-8))/runmax;
    rownm{dr}=['CMA-ES_cec13_f',num2str(fn)];
end
T={datav,rownm,colnm};
shT={T};
XT={[fio.addslash(1,fldn,sfldn{1}),'CMA-ES_rst.xls'],0,shT};
tio.xlswt(XT);
save([fio.addslash(1,fldn,sfldn{1}),'T.mat'], 'T');
save([fio.addslash(1,fldn,sfldn{1}),'runrst.mat'], 'runrst');
save([fio.addslash(1,fldn,sfldn{1}),'minvrst.mat'], 'minvrst');
save([fio.addslash(1,fldn,sfldn{1}),'meanvrst.mat'], 'meanvrst');
%% boxplot
fg=figure('visible','off');
boxplot(runrst);
set(gca,'YScale','log')
saveas(fg,[fio.addslash(1,fldn,sfldn{2}),'boxplot_f',ptfnm]);
close all
%% contour plot
parfor fn=funmin:funmax
    de.ctrplot_cmaes(fhd,fn,fio.addslash(1,fldn,sfldn{3}));
end
%% convergence graph
for i=1:funlen
    [srtrunrst,srtrunrstidx]=sort(runrst(:,i));
    fg=figure('visible','off');
    tminv=minvrst{srtrunrstidx(round(runmax/2)),i};
    semilogy(1:length(tminv),tminv(:),'r');
    ylabel('Err.');
    xlabel('Gen.');
    title(['convg.-f',num2str(i)]);
    hold on
    tmeanv=meanvrst{srtrunrstidx(round(runmax/2)),i};
    semilogy(1:length(tmeanv),tmeanv(:),'b');
    saveas(fg,[fio.addslash(1,fldn,sfldn{4}),'convg_f',num2str(i),ptfnm]);
    hold off
    close all
end
%% ranksum_test
rownm=cell(funlen,1);
colnm={'JADE'};
datav=cell(length(rownm),length(colnm));
dr=0;
for fn=funmin:funmax
    dr=dr+1;
    for ibv=1:length(colnm)
        tmsv=zeros(runmax,1);
        parfor rn=1:runmax
            dminv=de.jdfev(1000,100,10,fhd,fn,0.05,0.1);
            tmsv(rn)=dminv-optsol(fn);
        end
        tmsv(tmsv<1e-8)=0;
        rks(:,fn)=tmsv;
        [p,h,sta]=ranksum(tmsv,runrst(:,fn),'method','approximate');
        if h==1
            if sta.('zval')<0
                datav{dr,ibv}='-';
            else
                datav{dr,ibv}='+';
            end
        else
            datav{dr,ibv}='=';
        end
    end
    rownm{dr}=['CMAES-JADE-ranksum_cec13_f',num2str(fn)];
end
T={datav,rownm,colnm};
shT={T};
XT={[fio.addslash(1,fldn,sfldn{5}),'CMAES-JADE-ranksum.xls'],0,shT};
tio.xlswt(XT);
save([fio.addslash(1,fldn,sfldn{5}),'rks.mat'], 'rks');
toc;
%% ...
% X=repmat(m, 1, 10000)+B*sqrt(D)*randn(2,10000)