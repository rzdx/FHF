function [ O ] = dfrandi( L,N,varargin )
rjset=[];
for i=1:length(varargin)
rjset(i)=varargin{i};
end
i=0;
while i<L
    i=i+1;
    t=randi(N);
    if ~ismember(t,rjset)
        O(i)=t;
        rjset(length(rjset)+1)=t;
    else
        i=i-1;
    end
end
end

% L = number of random numbers
% N = max number of randi()
% varargin = List of never-appear elements