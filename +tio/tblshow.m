function tblshow( I ) %I{#}{1}=data,I{#}{2}=row names,I{#}{3}=col. names
scrnsz=get(0, 'ScreenSize');
scnw=scrnsz(3)/2;
scnh=scrnsz(4)/2;
wth=100;
hgt=50;
ftsz=12;
for i=1:length(I)
    w=wth*(length(I{i}{3})+2);
    h=hgt*length(I{i}{2});
    f=figure('Position',[scnw-w/2 scnh-h/2 w h]);
    uitable(...
        'Parent',f...
        ,'Data',I{i}{1}...
        ,'RowName',I{i}{2}...
        ,'ColumnName',I{i}{3}...
        ,'ColumnWidth',{wth}...
        ,'FontSize',ftsz...
        ,'Position',[0 0 w h]...
        );
end
end

% show tables at center of screen
% tblshow
% (
% I{#} = table_info(s)
% )