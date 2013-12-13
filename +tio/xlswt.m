function xlswt(XT)
if ~iscell(XT{2})
    XT{2}=cell(length(XT{3}),1);
    for i=1:length(XT{3})
        XT{2}{i}=XT{3}{i}{2}{1}(1:find(XT{3}{i}{2}{1}=='_')-1);
        for j=1:length(XT{3}{i}{2})
            XT{3}{i}{2}{j}=...
                XT{3}{i}{2}{j}(find(XT{3}{i}{2}{j}=='_')+1:length(XT{3}{i}{2}{j}));
        end
    end
end
for i=1:length(XT{3})
    tb=cell(size(XT{3}{i}{1},1)+1,size(XT{3}{i}{1},2)+1);
    tb{1,1}=XT{2}{i};
    for c=2:size(tb,2)
        tb{1,c}=XT{3}{i}{3}{c-1};
    end
    for r=2:size(tb,1)
        tb{r,1}=XT{3}{i}{2}{r-1};
    end
    for r=2:size(tb,1)
        for c=2:size(tb,2)
            if iscell(XT{3}{i}{1})
                tb{r,c}=XT{3}{i}{1}{r-1,c-1};
            else
                tb{r,c}=XT{3}{i}{1}(r-1,c-1);
            end
        end
    end
    xlswrite(XT{1},tb,XT{2}{i});
end
end

% XT{1}=filename:string
% XT{2}=sheetnames:cell - {index}:string || 0 :auto-fetch from 1st rowname before '_'
% XT{3}=tables:cell - {index} - {data_table{1},rowname_table{2},colname_table{3}}:cell
