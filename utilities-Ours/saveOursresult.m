function saveOursresult(para,vours,num_pic,psnr_ours,ssim_ours,tours,resultdir)
algorithm = '\Ours';
dir = sprintf('%s%s',resultdir,algorithm);
foldername = [para.name,'_',para.type,'_',num2str(num_pic)];
mkdir(dir,foldername);
%% save image
save([dir,'\',foldername,'\Oursreconstruction_',num2str(num_pic),'channels'],...
    'vours');
for i = 1:num_pic
    imwrite(vours(:,:,i)./255,[dir,'\',foldername,'\',...
        para.name,'_',para.type,'_',num2str(num_pic),'_',num2str(i),'.png'])
end
%% save evaluation
tours0 = zeros(size(psnr_ours));
tours0(1) = tours;
tours0(2) = mean(psnr_ours);
tours0(3) = mean(ssim_ours);
data = [psnr_ours',ssim_ours',tours0']; 
[m,n] = size(data);
data_cell = mat2cell(data, ones(m,1), ones(n,1)); 
title = {'psnr','ssim','Ê±¼ä/s'};
result = [title;data_cell];
xlswrite([dir,'\',foldername,'\',...
   para.name,'_',para.type,'_',num2str(num_pic),'.xls'],result);