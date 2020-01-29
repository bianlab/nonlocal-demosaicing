function  [vdct, psnr_dct, ssim_dct, tdct]    =   func_DCT( mask,m,orig )
addpath('.\utilities-DCT')

tic
[nrol,ncol,num_pic] = size(orig);
rates = 1/num_pic;
par = Set_parameters(rates);
par.nrol = nrol;
par.ncol = ncol;
vdct = zeros(size(orig),'like',orig);
psnr_dct = zeros(1,num_pic);
ssim_dct = zeros(1,num_pic);

lamada      =    1.5;  % 1.8, 1.2-1.7
% % b           =    par.win*par.win;
h = nrol;
D           =    dctmtx(h*h); %cal the basic of DCT
for i = 1:num_pic
    y = m(:,:,i);
    ori_im      =    orig(:,:,i);
    [h w]       =    size(ori_im);
    im          =    y; 
    for k   =  1:1
        f      =   im;
        for  iter = 1 : 300  

            if (mod(iter, 1) == 0)
                if isfield(par,'ori_im')
                    PSNR     =   psnr( f./255, par.ori_im./255, max(max(par.ori_im))./255 );                
                    fprintf( 'DCT Compressive Image Recovery, Iter %d : PSNR = %f\n', iter, PSNR );
                end
            end

            for ii = 1 : 3

                    fb = (mask(:,:,i)).*f;
                    f         =   f + lamada.*reshape( y-fb , h, w);
            end        
            f          =   DCT_thresholding( f, par, D );
        end
        im     =  f;
    end
    vdct(:,:,i)   =  im;
    psnr_dct(i) = psnr( vdct(:,:,i)./255, orig(:,:,i)./255, max(max( orig(:,:,i)./255 )) );
    ssim_dct(i) = ssim(vdct(:,:,i)./255, orig(:,:,i)./255 );
end

tdct = toc;
return;