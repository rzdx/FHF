function histo( I )

for i=1:size(I,3)
    h=zeros(256,1);
    for lv=0:255
        h(lv+1)=sum(sum(I(:,:,i)==lv));
    end
    figure;
    bar(h);
set(gca,'XLim',[1 256]);
xlabel('Gray Level');
ylabel('Freq.');
title(['Histogram-',num2str(i)]);
end

end