function [vours,psnr_ours,ssim_ours,tours] = func_Ours(mask,m,orig,rec_im0)
addpath(genpath('./utilities-Ours')); 
[nrol,ncol,num_pic] = size(orig);
rates = 1/num_pic;
par = Set_parameters(rates);
par.nrol = nrol;
par.ncol = ncol;
par.picks = mask;
par.y = m;    
par.ori_im = orig;% For computing PSNR only
[vours,K,tours]      =   NLR_Reconstruction( par, 255.*rec_im0); 

for i = 1:size(vours,3)
    psnr_ours(i)     =  psnr( vours(:,:,i)./255, par.ori_im(:,:,i)./255, max(max(par.ori_im(:,:,i)))./255 );
    ssim_ours(i)     =  ssim( vours(:,:,i)./255, par.ori_im(:,:,i)./255);
end

end