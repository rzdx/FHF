function [ O ] = gau( I,S )
O=I;
for r=1:size(I,1)
    for c=1:size(I,2)
        O(r,c,:)=I(r,c,:)+S*randn;
        for d=1:size(I,3)
            if O(r,c,d)>255
                O(r,c,d)=255;
            elseif O(r,c,d)<0
                O(r,c,d)=0;
            end
        end
    end
end
end