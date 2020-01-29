function [rec_im,K,tours]   =  NLR_Reconstruction( par, rec_im0 )
time0            =    clock;
rec_im           =    double( rec_im0 ); 
x0 = rec_im;
beta             =    0.01;
[h, w, ch]           =    size( rec_im );
iters            =    3;
diff = zeros(par.K,1);
K = zeros(par.K,1);
i = 1;
S = 60; % Block Matching: size of search window
for  k    =   1 : par.K 
    X_big = func_im2patch(rec_im,par);
    if mean( mean(abs(x0(:,:,1)-rec_im(:,:,1))) ) <=6e-4
        fprintf('Start Block Matching......%d\n',k)
        parfor(iframe = 1:ch,ch)
            pos_arr_single   =     Block_matching( rec_im, X_big, par,iframe,S);
            pos_arr_all(:,:,iframe) = pos_arr_single;
        end
        flag_BM = 1; km = k; K(i) = km; i = i+1;
        fprintf('End\n')
    else         
        flag_BM = 0;
    end
    x0 = rec_im;    
    f            =     rec_im;
    U_arr_all        =     zeros(par.win^4, size(pos_arr_all,2),ch,'single');
    if (k<=par.K0)  flag=0;  else flag=1;  end      
     
    for it  =  1 : iters
        parfor (i = 1:ch,ch)
            f0 = f(:,:,i);
            blk_arr = pos_arr_all(:,:,i);
            U_arr = U_arr_all(:,:,i);
            [rim0, wei0, U_arr0]      =   Low_rank_appro(f0, par, blk_arr, X_big',U_arr, it, flag,i,ch );   
            rim(:,:,i)   =   (rim0+beta*f0)./(wei0+beta);
            U_arr_all(:,:,i) = U_arr0;
        end
         for n = 1:size(rim,3)
            rim0 = rim(:,:,n);
            AtY = par.y(:,:,n);
            f0 = f(:,:,n);
            b               =   AtY(:) + beta * rim0(:);
            [X flag0]       =   pcg( @(x) Afun(x, beta, par, n), b, 0.5E-6, 400, [], [], f0(:));          
            f0               =   reshape(X, h, w); 
            f(:,:,n) = f0;
        end
    end
    rec_im    =   f;
    diff(k)     =  mean( mean(abs(x0(:,:,1)-rec_im(:,:,1))) );
    % beta       =   beta * 1.05;   
   if flag_BM == 1 && diff(k) <=0.011
       break
   end
    
end
time1 = clock;
tours = etime(time1,time0);

return;


%======================================================
function  y  =  Afun(x, eta, par, n)
pattern = par.picks(:,:,n);
y = reshape(x,size(pattern)).*pattern;
y      =   y(:) + eta*x;  
return;

