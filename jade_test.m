mpool

ptfnm='.fig';
% ptfnm='.png';
% fldn='result-p';
fldn='result';
sfldn={'meanstd','boxplot','contour','convg','uCRuF','p&c','ranksum'};
fio.nfolds(fldn,sfldn);

stdp=0.05;
stdc=0.1;

% Gmax=10;
% NP=40;
Gmax=2000;
NP=150;
d=30;
funmin=1;
funmax=28;
runmax=10;
funlen=funmax-funmin+1;

fhd='cec13_func';
optsol=(-1400:100:1400);
optsol(15)=[];

runrst=zeros(runmax,funlen);
minvrst=zeros(runmax,funlen,Gmax);
meanvrst=minvrst;
uCRrst=minvrst;
uFrst=minvrst;

tic;

rownm=cell(funlen,1);
colnm={'mean','std','success_rate'};
datav=zeros(length(rownm),length(colnm));
dr=0;
p=stdp;
c=stdc;
for fn=funmin:funmax
    tmsv=zeros(runmax,1);
    parfor rn=1:runmax
        [jdminv,jdminpara,jdgminv,jdgmeanv,jdsuCR,jdsuF]=de.jdfev(Gmax,NP,d,fhd,fn,p,c,rn);
        tmsv(rn)=jdminv-optsol(fn);
        minvrst(rn,fn,:)=jdgminv-optsol(fn);
        meanvrst(rn,fn,:)=jdgmeanv-optsol(fn);
        uCRrst(rn,fn,:)=jdsuCR;
        uFrst(rn,fn,:)=jdsuF;
    end
    mn=mean(tmsv);
    sd=std(tmsv,1);
    if mn<1e-8
        mn=0;
    end
    if sd<1e-8
        sd=0;
    end
    dr=dr+1;
    runrst(:,dr)=tmsv;
    datav(dr,1)=mn;
    datav(dr,2)=sd;
    datav(dr,3)=length(tmsv(tmsv<1e-8))/runmax;
    rownm{dr}=['Jade(p=',num2str(p),' c=',num2str(c),')_cec13_f',num2str(fn)];
end
T={datav,rownm,colnm};
shT={T};
XT={[fio.addslash(1,fldn,sfldn{1}),'jade_rst.xls'],0,shT};
tio.xlswt(XT);

for i=1:funlen
    fg=figure;
    boxplot(runrst(:,i));
    title(['boxplot-f',num2str(i)]);
    saveas(fg,[fio.addslash(1,fldn,sfldn{2}),'boxplot_f',num2str(i),ptfnm]);
    close all;
end

for i=1:funlen
    [srtrunrst,srtrunrstidx]=sort(runrst(:,i));
    fg=figure;
    tminv=minvrst(srtrunrstidx(round(runmax/2)),i,:);
    plot(1:Gmax,tminv(:),'r');
    axis([1,Gmax,0,max(tminv)])
    ylabel('Err.');
    xlabel('Gen.');
    title(['convg.-f',num2str(i)]);
    hold on
    tmeanv=meanvrst(srtrunrstidx(round(runmax/2)),i,:);
    plot(1:Gmax,tmeanv(:),'b');
    saveas(fg,[fio.addslash(1,fldn,sfldn{4}),'convg_f',num2str(i),ptfnm]);
    hold off
    
    fg=figure;
    tuCR=uCRrst(srtrunrstidx(round(runmax/2)),i,:);
    plot(1:Gmax,tuCR(:));
    axis([1,Gmax,0,1])
    ylabel('uCR');
    xlabel('Gen.');
    title(['uCR.-f',num2str(i)]);
    saveas(fg,[fio.addslash(1,fldn,sfldn{5}),'uCR_f',num2str(i),ptfnm]);
    
    fg=figure;
    tuF=uFrst(srtrunrstidx(round(runmax/2)),i,:);
    plot(1:Gmax,tuF(:));
    axis([1,Gmax,0,1])
    ylabel('uF');
    xlabel('Gen.');
    title(['uF.-f',num2str(i)]);
    saveas(fg,[fio.addslash(1,fldn,sfldn{5}),'uF_f',num2str(i),ptfnm]);
    
    close all;
end

Tct=0;
T=cell(9,1);
for p=stdp-(stdp/2):(stdp/2):stdp+(stdp/2)
    for c=stdc-(stdc/2):(stdc/2):stdc+(stdc/2)
        rownm=cell(funlen,1);
        colnm={'mean','std','success_rate'};
        datav=zeros(length(rownm),length(colnm));
        dr=0;
        for fn=funmin:funmax
            tmsv=zeros(runmax,1);
            parfor rn=1:runmax
                [jdminv,jdminpara,jdgminv,jdgmeanv,jdsuCR,jdsuF]=de.jdfev(Gmax,NP,d,fhd,fn,p,c,0);
                tmsv(rn)=jdminv-optsol(fn);
            end
            mn=mean(tmsv);
            sd=std(tmsv,1);
            if mn<1e-8
                mn=0;
            end
            if sd<1e-8
                sd=0;
            end
            dr=dr+1;
            datav(dr,1)=mn;
            datav(dr,2)=sd;
            datav(dr,3)=length(tmsv(tmsv<1e-8))/runmax;
            rownm{dr}=['Jade(p=',num2str(p),'&c=',num2str(c),')_cec13_f',num2str(fn)];
        end
        Tct=Tct+1;
        T{Tct}={datav,rownm,colnm};
    end
end
shT={T{1:length(T)}};
XT={[fio.addslash(1,fldn,sfldn{6}),'jade_rst(p&c).xls'],0,shT};
tio.xlswt(XT);

rownm=cell(funlen,1);
colnm={'DE/rand/1/bin','DE/best/1/bin','DE/current-to-best/1/bin'};
datav=cell(length(rownm),length(colnm));
dr=0;
for fn=funmin:funmax
    dr=dr+1;
    for ibv=1:3
        tmsv=zeros(runmax,1);
        parfor rn=1:runmax
            [dminv,dminpara]=de.dfev(Gmax,NP,d,ibv,fhd,fn);
            tmsv(rn)=dminv-optsol(fn);
        end
        tmsv(tmsv<1e-8)=0;
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
    rownm{dr}=['JADE-DE-ranksum_cec13_f',num2str(fn)];
end
T={datav,rownm,colnm};
shT={T};
XT={[fio.addslash(1,fldn,sfldn{7}),'JADE-DE-ranksum.xls'],0,shT};
tio.xlswt(XT);

toc;