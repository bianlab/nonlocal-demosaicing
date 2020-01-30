clc;clear;close all
%% [0] environment configuration
datasetdir = './data'; % dataset
resultdir  = './results'; % results

%% [1] load dataset
para.name   = 'toy_noiseless'; % name of dataset
type = 'btes';   % type of mask : regular / random / btes
num_pic = 6;    % number of frames in the dataset
para.type   = type; 
para.number =  num_pic; 
datapath = sprintf('%s/%s_%s_%d.mat',datasetdir,para.name,...
    para.type,num_pic);

if exist(datapath,'file')
    load(datapath); % including: mask, meas, m, orig (and para)
else
    error('File %s does not exist, please check dataset directory!',...
        datapath);
end
        %------------- Start Parallel ----------
          delete(gcp('nocreate')); % delete current parpool
          mycluster = parcluster('local');
          div = 1;
          while num_pic/div > mycluster.NumWorkers
              div = div+1;
          end
          parnum = max(min(ceil(num_pic/div),mycluster.NumWorkers),1); 
          parpool(mycluster,parnum+1);
        %---------------------------------------
%% [2.1] BTES reconstruction
        var = 0;
        [vbtes, psnr_btes, ssim_btes,tbtes] = func_BTE(orig,num_pic,mask,var);
        saveBTESresult(para,vbtes,num_pic,psnr_btes,ssim_btes,tbtes,resultdir)
%% [2.2] DCT reconstruction
        [vdct,psnr_dct,ssim_dct,tdct]  = func_DCT(mask,m,orig);
        saveDCTresult(para,vdct,num_pic,psnr_dct,ssim_dct,tdct,resultdir);
%% [2.3] GAP-TV reconstruction 
         [vgaptv,psnr_gaptv,ssim_gaptv,tgaptv]  = func_GAPTV(mask,meas,orig);
         saveGAPTVresult(para,vgaptv,num_pic,psnr_gaptv,ssim_gaptv,tgaptv,resultdir);
%% [2.4] Ours reconstruction
         [vours,psnr_ours,ssim_ours,tours] = func_Ours(mask,m,orig,255.*vgaptv);
         saveOursresult(para,vours,num_pic,psnr_ours,ssim_ours,tours,resultdir);
         
         
delete(gcp('nocreate')); % delete current parpool





