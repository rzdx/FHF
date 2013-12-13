function [ O ] = cauchyPDF( x,varargin )

if nargin==1
    x0=0;
    r=1;
elseif nargin==2
    x0=0;
    r=varargin{1};
elseif nargin==3
    x0=varargin{1};
    r=varargin{2};
else
    error('|parameter| <=3');
end

b=(x-x0)/r;
a=1+b^2;
d=pi*r*a;
O=1/d;
end

