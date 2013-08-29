function [ O ] = zotrans( I )
[R,C,D]=fn.getsz(I);
O=zeros(R,C,D);
for r=1:R
    for c=1:C
        for d=1:D
            if I(r,c,d)==1
                O(r,c,d)=0;
            elseif I(r,c,d)==0
                O(r,c,d)=1;
            else
                O(r,c,d)=I(r,c,d);
            end
        end
    end 
end
end