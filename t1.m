G=[1,500,1000,1500,2000];
for i=1:28
    for j=1:5
        s=['contour_f',num2str(i),'_g',num2str(G(j))];
        fg=open([s,'.fig']);
        saveas(fg,[s,'.png']);
    end
    close all;
end