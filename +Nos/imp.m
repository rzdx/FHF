function [ O ] = imp( I,p )
O=I;
nosp=Nos.nospt(I(:,:,1),p);
for i=1:3
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