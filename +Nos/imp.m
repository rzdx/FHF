function [ O ] = imp( I,p )
O=I;
for i=1:3
    Ot=I(:,:,i);
    nosp=Nos.nospt(I(:,:,i),p);
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