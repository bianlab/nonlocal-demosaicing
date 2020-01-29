function X_big = func_im2patch(im,par)
nframe = size(im,3);
f         =   par.win;
N         =   size(im,1)-f+1;
M         =   size(im,2)-f+1;
L         =   N*M;
X_big         =   zeros(L*nframe, f*f, 'single');

for n = 1:nframe
    pos = (n-1)*N*M+1:n*N*M;
    k    =  0;
    for i  = 1:f
        for j  = 1:f
            k    =  k+1;
            blk  =  im(i:end-f+i,j:end-f+j,n);
            X_big( pos' ,k ) =  blk(:);
        end
    end
end










