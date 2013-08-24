function [ O ] = fznb( I )
c=0.006;
w=0.003;
b={c-w,c,c+w,c+(2*w),0.5};
s={w,w,w,w,0.5};
m={exp(-1),1,exp(-1),exp(-4),0};

end