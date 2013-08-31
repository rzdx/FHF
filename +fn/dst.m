function [ O ] = dst( p1,p2 )
O=norm(double(p1(:))-double(p2(:)));
end

% [
% O = norm of p1-p2   
% ]
% = dst
% (
% p1 = input_vector_1
% p2 = input_vector_2
% )


% if fn.mul(size(p1))~=fn.mul(size(p2))
%     error('-diff. dim.-');
% end
% s=0;
% for j=1:fn.mul(size(p1))
%     s=s+((p1(j)-p2(j))^2);
% end
% O=sqrt(s);