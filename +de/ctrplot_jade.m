function ctrplot(Gmax,NP,d,evfnnm,evn,p,c)
uCR=0.5;
uF=0.5;
A=[];

Xmax=zeros(d,1)+100;
Xmin=zeros(d,1)-100;
X=zeros(d,NP);
newX=X;
tX=zeros(d,1);
U=tX;
for np=1:NP
    for i=1:d
        tX(i)=Xmin(i)+rand*(Xmax(i)-Xmin(i));
    end
    X(:,np)=tX;
end

gminv=zeros(Gmax,1);
evX=evalX(X,evfnnm,evn);
suCR=gminv;
suF=suCR;
for G=1:Gmax
    sCR=[];
    sF=[];
    CR=zeros(1,NP);
    F=CR;
    
    [srtX,srtXidx]=sort(evX);
    srtXidx=srtXidx(1:round(p*NP));
    for i=1:NP
        do=1;
        while do
            CR(i)=random('normal',uCR,0.1);
            if CR(i)>=0&&CR(i)<=1
                do=0;
            end
        end
        do=1;
        while do
            F(i)=cauchy.cauchyrnd(uF,0.1);
            if F(i)>=0&&F(i)<=1
                do=0;
            end
        end
        pbidx=srtXidx(randi(length(srtXidx)));
        r1=fn.dfrandi(1,NP,i);
        r2=fn.dfrandi(1,NP+size(A,2),i,r1);
        
        Xi=X(:,i);
        Xpb=X(:,pbidx);
        Xr1=X(:,r1);
        if r2<=NP
            Xr2=X(:,r2);
        else
            Xr2=A(:,r2-NP);
        end
        
        V=Xi+F(i)*(Xpb-Xi)+F(i)*(Xr1-Xr2);
        
        randj=randi(d);
        for j=1:d
            if rand<=CR(i)||randj==j
                U(j)=V(j);
            else
                U(j)=X(j,i);
            end
        end
        
        if evX(i)<=feval(evfnnm,U,evn)
            newX(:,i)=X(:,i);
        else
            newX(:,i)=U;
            A(:,size(A,2)+1)=X(:,i);
            sCR(length(sCR)+1)=CR(i);
            sF(length(sF)+1)=F(i);
        end
    end
    X=newX;
    evX=evalX(X,evfnnm,evn);
    
    if size(A,2)>NP
        A(:,fn.dfrandi(size(A,2)-NP,size(A,2)))=[];
    end
    if ~isempty(sCR)
        uCR=(1-c)*uCR+c*mean(sCR);
        uF=(1-c)*uF+c*meanL(sF);
    end
    suCR(G)=uCR;
    suF(G)=uF;
    
    %     ploto(X,evfnnm,evn,-100,-100,100,100,G,1);
    
    if (ismember(G,round(Gmax*((1:4)/4)))||G==1)
        ploto(X,evfnnm,evn,-100,-100,100,100,G);
    end
end
end

function [evX]=evalX(X,evfnnm,evn)
evX=zeros(size(X,2),1);
for i=1:size(X,2)
    evX(i)=feval(evfnnm,X(:,i),evn);
end
end

function [O]=meanL(sF)
u=sum(sF.^2);
d=sum(sF);
O=u/d;
end

function ploto(X,evfnnm,evn,xmin,ymin,xmax,ymax,G)
ptfnm='.png';
fg=figure('visible','off');
x=linspace(xmin, xmax, 200);
y=linspace(ymin, ymax, 200);
[xx,yy] = meshgrid(x,y);
zz=zeros(length(x),length(y));
for i=1:numel(x)
    for j=1:numel(y)
        xi = xx(i,j);
        yi = yy(i,j);
        zz(i,j)=feval(evfnnm,[xi;yi],evn);
    end
end
contour(xx,yy,zz);
colorbar;
axis ([xmin,xmax,ymin,ymax]);
title(['Contour-f',num2str(evn),' Generation-',num2str(G)]);
hold on
plot(X(1,:),X(2,:),'kx','MarkerSize',12,'LineWidth',2);
pause(0.01);
saveas(fg,[fio.addslash(1,'result-p','contour'),'contour_f',num2str(evn),'_g',num2str(G),ptfnm]);
hold off
end
