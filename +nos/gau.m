function [ O ] = gau( I,S )
O=I;
MAXI=255;
for i=1:size(I,3)
    Ot=I(:,:,i);
    acc=0;
    nosp=nos.nospt(size(I,1),size(I,2),100);
    for z=-MAXI:MAXI
        nz=int32(pdf(z,0,S)*(size(I,1)*size(I,2)));
        for j=acc+1:acc+nz
            if j>length(nosp)
                break;
            end
            Ot(nosp(j))=Ot(nosp(j))+z;
        end
        acc=acc+nz;
    end    
    O(:,:,i)=Ot;
end
end

function [ P ] = pdf(Z,M,S)
P=exp(-((Z-M)^2)/(2*(S^2)))/(S*sqrt((2*pi)));
end