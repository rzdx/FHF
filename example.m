if matlabpool('size') == 0
matlabpool('open');
end

tic;
A = zeros(1, 1000);

parfor i = 1 : 1000
    A(i) = min(eig(randn(100)));
end
toc;