function [ O ] = dst( p1,p2 )
if ~isequal(size(p1),size(p2))
    error('-diff. dim.-');
end
s=0;
for j=1:Fn.mul(size(p1))
    s=s+((p1(j)-p2(j))^2);
end
O=sqrt(s);
end

