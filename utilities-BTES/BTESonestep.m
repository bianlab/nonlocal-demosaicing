function [interpolated]=BTESonestep(x,toprow,topcol,var)

%BTES algorithm requires rotate(45) => interpolation=> rotate(-45)
%all these steps are done here
if(strcmp(var,'even'))
    y=zeros(size(x));
    startcol=size(x,2)/2+topcol;
    startrow=toprow;
    %c=startcol1center+1;
    r=startrow+1;
        c=startcol-1;
    for i=toprow:2:size(x,1)
        rr=r;
        cc=c;
        for j=topcol:2:size(x,2)
            y(rr,cc)=x(i,j);
            rr=rr+1;
            cc=cc+1;
        end
        c=c-1;
        r=r+1;
    end
    interimg=  nlfilter(y,[7,7],@BTESinterpolate);
    y=y+interimg;

     z=x;
     startcol=size(y,2)/2+topcol-1;
     startrow=toprow+2;

     r=startrow;
     c=startcol;
    for i=toprow+1:2:size(x,1)-2
        rr=r;
        cc=c;
         for j=topcol+1:2:size(x,2)-1
             z(i,j)=y(rr,cc);
            rr=rr+1;
            cc=cc+1;
        end
        c=c-1;
        r=r+1;
    end

    interpolated=z;
elseif (strcmp(var,'odd'))
    interpolated=  nlfilter(x,[7,7],@BTESinterpolate);
end
end
    