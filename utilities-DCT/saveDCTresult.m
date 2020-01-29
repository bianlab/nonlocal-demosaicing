function saveDCTresult(para,vdct,num_pic,psnr_dct,ssim_dct,tdct,resultdir)
algorithm = '\DCT';
dir = sprintf('%s%s',resultdir,algorithm);
foldername = [para.name,'_',para.type,'_',num2str(num_pic)];
mkdir(dir,foldername);
%% save image
save([dir,'\',foldername,'\DCTreconstruction_',num2str(num_pic),'channels'],...
    'vdct');
for i = 1:num_pic
    imwrite(vdct(:,:,i)./255,[dir,'\',foldername,'\',...
        para.name,'_',para.type,'_',num2str(num_pic),'_',num2str(i),'.png'])
end
%% save evaluation
tdct0 = zeros(size(psnr_dct));
tdct0(1) = tdct;
tdct0(2) = mean(psnr_dct);
tdct0(3) = mean(ssim_dct);
data = [psnr_dct',ssim_dct',tdct0']; 
[m,n] = size(data);
data_cell = mat2cell(data, ones(m,1), ones(n,1)); 
title = {'psnr','ssim','Ê±¼ä/s'};
result = [title;data_cell];
xlswrite([dir,'\',foldername,'\',...
   para.name,'_',para.type,'_',num2str(num_pic),'.xls'],result);