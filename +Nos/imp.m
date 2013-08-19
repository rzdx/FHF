function [ O ] = imp( I,p )
[R,C]=Fn.getsz(I);
O=I;
nosp=Nos.nospt(R,C,p);
for i=1:size(I,3)
    Ot=I(:,:,i);
    for j=1:length(nosp);
        if rand<=0.5
            Ot(nosp(j))=255;
        else 
            Ot(nosp(j))=0;
        end
    end
    O(:,:,i)=Ot;
end
end