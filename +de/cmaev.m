function [minv,minpara,gminv,gmeanv] = cmaev(d,evfnnm,evn)

lbd=-100;
ubd=100;
dfsigma=120;
dflambda=4+floor(3*log(d));

maxrtct=15;

G=0;
rtct=0;
rgm1ct=0;
rgm2ct=0;
bestGXv=NaN*ones(1,maxrtct);
bestGX=NaN*ones(d,maxrtct);
rtorder=[1,2,zeros(1,maxrtct-2)];
while rtct<maxrtct
    rtct=rtct+1;
    
    if rtct==3
        if bestGXv(1)<bestGXv(2)
            rgm1max=round(maxrtct*(2/3));
            rtorder(3:3+rgm1max-2)=ones(1,rgm1max-1);
        else
            rgm1max=round(maxrtct*(1/3));
            rtorder(3:3+rgm1max-2)=ones(1,rgm1max-1);
        end
        for i=1:length(rtorder)
            if rtorder(i)==0
                rtorder(i)=2;
            end
        end
    end
    
    rgm=rtorder(rtct);
    if rgm==1  %regime(1)
        sigma=dfsigma/(1.6^rgm1ct);
        lambda=dflambda*(2^rgm1ct);
        rgm1ct=rgm1ct+1;
    else       %regime(2)
        sigma=dfsigma*(10^(-2*rand));
        lambda=dflambda;
        rgm2ct=rgm2ct+1;
    end
    termi=0;
    countiter=0;
    counteval=0;
    mu = floor(lambda/2);
    wts = log((lambda+1)/2) - log(1:mu)';
    mueff=sum(wts)^2/sum(wts.^2);
    wts=wts/sum(wts);
    xmeanw=ones(d,1);
    cc = 4/(d+4);
    cs = (mueff+2)/(d+mueff+3);
    B = eye(d);
    D = eye(d);
    BD = B*D;
    C = BD*transpose(BD);
    pc = zeros(d,1);
    ps = zeros(d,1);
    chiN = d^0.5*(1-1/(4*d)+1/(21*d^2));
    arrEqualFunvals = zeros(1,10+d);
    hist=NaN*ones(1,10+ceil(3*10*d/lambda));
    histbest=[];
    histmedian=[];
    
    while termi==0
        G=G+1;
        countiter=countiter+1;
        arx=zeros(d,lambda);
        arz=arx;
        for i=1:lambda
            arz(:,i) = randn(d,1);
            arx(:,i) = xmeanw + sigma * (BD * arz(:,i));
            counteval = counteval+1;
        end
        arx=fn.ublbcrt(arx,lbd,ubd);
        Xv=evalX(arx,evfnnm,evn);
        [Xv, Xvidx]=sort(Xv);
        
        hist(2:end)=hist(1:end-1);
        hist(1)=Xv(1);
        if length(histbest) < 120+ceil(30*d/lambda) || ...
                (mod(countiter, 5) == 0  && length(histbest) < 2e4)
            histbest = [Xv(1) histbest];
            histmedian = [median(Xv) histmedian];
        else
            histbest(2:end) = histbest(1:end-1);
            histmedian(2:end) = histmedian(1:end-1);
            histbest(1) = Xv(1);
            histmedian(1) = median(Xv);
        end
        
        xold = xmeanw;
        xmeanw = arx(:,Xvidx(1:mu))*wts;
        zmeanw = arz(:,Xvidx(1:mu))*wts;
        
        ccov1= 2/((d+1.3)^2+mueff);
        ccovmu= 2 * (mueff-2+1/mueff) / ((d+2)^2+mueff);
        alphaold=0.5;
        hsig = norm(ps)/sqrt(1-(1-cs)^(2*countiter))/chiN < 1.4 + 2/(d+1);
        ccov = (1 - ccovmu) * 0.25 * mueff / ((d+2)^1.5 + 2*mueff);
        ccovfinal = ccov;
        arzneg = arz(:,Xvidx(lambda:-1:lambda - mu + 1));
        [arnorms,idxnorms] = sort(sqrt(sum(arzneg.^2, 1)));
        [ignore,idxnorms] = sort(idxnorms);
        arnormfacs = arnorms(end:-1:1) ./ arnorms;
        arzneg = arzneg .* repmat(arnormfacs(idxnorms), d, 1);
        artmp = BD * arzneg;
        Cneg = artmp * diag(wts) * artmp';
        arpos = (arx(:,Xvidx(1:mu))-repmat(xold,1,mu)) / sigma;
        
        pc = (1-cc)*pc + hsig*(sqrt(cc*(2-cc)*mueff)/sigma) * (xmeanw-xold);
        C = (1-ccov1-ccovmu+alphaold*ccovfinal+(1-hsig)*ccov1*cc*(2-cc)) * C + ccov1 * pc*pc' ...
            + (ccovmu + (1-alphaold)*ccovfinal) ...
            * arpos * (repmat(wts,1,d) .* arpos') ...
            - ccovfinal * Cneg;
        
        damps = 1 + 2*max(0,sqrt((mueff-1)/(d+1))-1) + cs;
        ps = (1-cs)*ps + sqrt(cs*(2-cs)*mueff) * (B*zmeanw);
        sigma = sigma * exp(min(1, (sqrt(sum(ps.^2))/chiN - 1) * cs/damps));
        if mod(countiter/lambda, d/10) < 1
            C=triu(C)+transpose(triu(C,1));
            [B,D] = eig(C);
            if max(diag(D)) > 1e14*min(diag(D))
                tmp = max(diag(D))/1e14 - min(diag(D));
                C = C + tmp*eye(d);
                D = D + tmp*eye(d);
            end
            D = diag(sqrt(diag(D)));
            BD = B*D;
        end
        
        stopMaxFunEvals=d*10000 ;
        stopFitness=-Inf;
        stopMaxIter=1e3*(d+5)^2/sqrt(lambda) ;
        stopFunEvals=Inf;
        stopIter=Inf;
        stopTolX=1e-11*max(sigma);
        stopTolUpX=1e3*max(sigma);
        stopTolFun=1e-12 ;
        stopTolHistFun=1e-13 ;
        
        if counteval >= stopMaxFunEvals
            termi=2;
        end
        if Xv(1)<= stopFitness
            termi=1;
        end
        if countiter >= stopMaxIter
            termi=3;
        end
        if all(sigma*(max(abs(pc), sqrt(diag(C)))) < stopTolX)
            termi=4;
        end
        if any(sigma*sqrt(diag(C)) > stopTolUpX)
            termi=5;
        end
        if countiter > 2 & max(hist)-min(hist) <= stopTolFun
            termi=6;
        end
        if countiter >= length(hist) & max(hist)-min(hist) <= stopTolHistFun
            termi=7;
        end
        l = floor(length(histbest)/3);
        if countiter>d*(5+100/lambda) & ...
                length(histbest)>100 & ...
                median(histmedian(1:l)) >= median(histmedian(end-l:end)) & ...
                median(histbest(1:l)) >= median(histbest(end-l:end))
            termi=8;
        end
        if counteval >= stopFunEvals || countiter >= stopIter
            termi=9;
        end
        if Xv(1) == Xv(1+ceil(0.1+lambda/4))
            arrEqualFunvals = [countiter arrEqualFunvals(1:end-1)];
            if arrEqualFunvals(end) > countiter - 3 * length(arrEqualFunvals)
                termi=10;
            end
        end
        ggminv(G)=Xv(1);
        ggmeanv(G)=mean(Xv);
    end
    bestGXv(rtct)=Xv(1);
    bestGX(:,rtct)=arx(:,Xvidx(1));
end
[minv,minidx]=min(bestGXv);
minpara=bestGX(:,minidx);
gminv=ggminv;
gmeanv=ggmeanv;
end

function [evX]=evalX(X,evfnnm,evn)
evX=zeros(size(X,2),1);
for i=1:size(X,2)
    evX(i)=feval(evfnnm,X(:,i),evn);
end
end