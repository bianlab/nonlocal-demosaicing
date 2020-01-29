function Xestimated=BTESinterpolate(x)
%Here x is a 7 by 7 window and at the center we have to do estimation.
%center is (4,4)
V=[0 0];
H=[0 0];
i=1;n=4;
for m=[3 5]
    V(i)= 1/(1+abs(x(m+2,n)-x(m,n))+abs(x(m-2,n)-x(m,n))+...
    0.5*abs(x(m-1,n-1)-x(m+1,n-1))+0.5*abs(x(m-1,n+1)-x(m+1,n+1)));
    i=i+1;
end
 
i=1; m=4;
for n=[3 5]
    H(i)=1/(1+ abs(x(m,n+2)-x(m,n))+abs(x(m,n-2)-x(m,n)) +...
    0.5*abs(x(m+1,n-1)-x(m+1,n+1))+0.5*abs(x(m-1,n-1)-x(m-1,n+1)));
    i=i+1;
end

%interploate value
i=4; j=4;
wh1=H(1);wh2=H(2);wv1=V(1); wv2=V(2);
c=x(i-1,j);d=x(i+1,j);a=x(i,j-1);b=x(i,j+1);

Xestimated=(wh1*a+wh2*b+wv1*c+wv2*d)/...
     (wh1+wh2+wv1+wv2); 


end