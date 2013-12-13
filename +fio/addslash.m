function [ O ] = addslash( tag,varargin )
O='';
for i=1:length(varargin)
    O=[O,varargin{i},'\'];
end
if tag==0
    O(length(O))=[];
end
end
% tag: 0 = no slash at final place, 1 = a slash at final place
% varargin = strings to concatenate with '\'