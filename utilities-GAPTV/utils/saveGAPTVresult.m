function saveGAPTVresult(para,vgaptv,num_pic,psnr_gaptv,ssim_gaptv,tgaptv,resultdir)
algorithm = '\GAPTV';
dir = sprintf('%s%s',resultdir,algorithm);
%dir = '.\results\GAPTV';
foldername = [para.name,'_',para.type,'_',num2str(num_pic)];
mkdir(dir,foldername);
%% save image
save([dir,'\',foldername,'\GAPTVreconstruction_',num2str(num_pic),'channels'],...
    'vgaptv');
for i = 1:num_pic
    imwrite(vgaptv(:,:,i),[dir,'\',foldername,'\',...
        para.name,'_',para.type,'_',num2str(num_pic),'_',num2str(i),'.png'])
end
%% save evaluation
tgaptv0 = zeros(size(psnr_gaptv));
tgaptv0(1) = tgaptv;
tgaptv0(2) = mean(psnr_gaptv);
tgaptv0(3) = mean(ssim_gaptv);
data = [psnr_gaptv',ssim_gaptv',tgaptv0']; 
[m,n] = size(data);
data_cell = mat2cell(data, ones(m,1), ones(n,1)); 
title = {'psnr','ssim','Ê±¼ä/s'};
result = [title;data_cell];
xlswrite([dir,'\',foldername,'\',...
   para.name,'_',para.type,'_',num2str(num_pic),'.xls'],result);