function [vbtes, psnr_btes, ssim_btes,tbtes] = func_BTE(orig,num_pic,mask,var)
addpath(genpath('./utilities-BTES')); 
psnr_btes = zeros(1,num_pic);
ssim_btes = zeros(1,num_pic);
tic

orig_noisy = zeros(size(orig));

if var == 0
    orig_noisy = orig;
else
    for i = 1:num_pic
        orig_noisy(:,:,i) = imnoise(uint8(orig(:,:,i)), 'gaussian', 0, var);
    end
end

orig_noisy = double(orig_noisy);

    switch num_pic
        case 4
            [vbtes img_] = btes4(orig_noisy./255,mask);
        case 5
            [vbtes img_] = btes5(orig_noisy./255,mask);
        case 6
            [vbtes img_] = btes6(orig_noisy./255,mask);
        case 7
            [vbtes img_] = btes7(orig_noisy./255,mask);
        case 8
            [vbtes img_] = btes8(orig_noisy./255,mask);
        case 9
            [vbtes img_] = btes9(orig_noisy./255,mask);
        otherwise
            [vbtes img_] = btes9(orig_noisy./255,mask);
    end
    time=toc;
    vbtes=im2uint8(vbtes); img_=im2uint8(img_);
    for i = 1:num_pic
        PSNRmid = psnr(double(vbtes(:,:,i))./255,double(orig(:,:,i))./255,max(max(orig(:,:,i)))./255);
        psnr_btes(1,i) = PSNRmid;
        SSIMmid = ssim( double(vbtes(:,:,i))./255,double(orig(:,:,i))./255 );
        ssim_btes(1,i) = SSIMmid;
    end
    tbtes = time;
end
    
   
