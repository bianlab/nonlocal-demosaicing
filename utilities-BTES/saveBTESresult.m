function saveBTESresult(para,vbtes,num_pic,psnr_btes,ssim_btes,tbtes,resultdir)
algorithm = '\BTES';
dir = sprintf('%s%s',resultdir,algorithm);
foldername = [para.name,'_',para.type,'_',num2str(num_pic)];
mkdir(dir,foldername);
%% save image
save([dir,'\',foldername,'\BTESreconstruction_',num2str(num_pic),'channels'],...
    'vbtes');
for i = 1:num_pic
    imwrite((vbtes(:,:,i)),[dir,'\',foldername,'\',...
        para.name,'_',para.type,'_',num2str(num_pic),'_',num2str(i),'.png'])
end
%% save evaluation
tbtes0 = zeros(size(psnr_btes));
tbtes0(1) = tbtes;
tbtes0(2) = mean(psnr_btes);
tbtes0(3) = mean(ssim_btes);
data = [psnr_btes',ssim_btes',tbtes0']; 
[m,n] = size(data);
data_cell = mat2cell(data, ones(m,1), ones(n,1)); 
title = {'psnr','ssim','Ê±¼ä/s'};
result = [title;data_cell];
xlswrite([dir,'\',foldername,'\',...
   para.name,'_',para.type,'_',num2str(num_pic),'.xls'],result);