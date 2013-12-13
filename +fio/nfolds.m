function nfolds(fldn,sfldn)
for i=1:length(sfldn)
    if ~exist([fldn,'\',sfldn{i}],'dir')
        mkdir([fldn,'\',sfldn{i}]);
    end
end
end