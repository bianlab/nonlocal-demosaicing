%Implementation of BTES algorithm of paper "binary tree-based generic
%demosaicking algorithm for multispectral filter arrays" by Lidan Miao.
%Vol 15 No. 11 Nov 2006, Transactions on image processing

% This program is for 5 band multispectral images.
function [newimg img]=btes5(img,mask)
%clc; clear all; close all;

%read a multispectral image of four bands
% m=1829;n=2034;dim=6; 
% %m=1754;n=1653;dim=4;
% img=multibandread('MultispectralData\img1999',[ m n dim],...
%                         'uint8=>uint8',0,'bsq','ieee-le');
% % for i=1 :dim
% %     img(:,:,i)=histeq(img(:,:,i));
% % end
% 
% %img=randi(255,15,14,4);
% %make no.of rows and cols as multiple of 4 so that
% % we can apply filters of band 1 and 2.
% img=im2double(img(1000:1500,1000:1500,[2 3 4 5 6]));
img=img(1:floor(size(img,1)/4)*4,1:floor(size(img,2)/4)*4,:);
[m n dim]=size(img) ;%redefine variables m, n , dim
%imshow(img(:,:,[4 3 2 ])); %img is in double

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%make the template for mask
rawimg=zeros(size(img));

%multiply the mask wih individual bands to get band values at specific
%points such that rawimg have individual band values.
for i=1:5
    rawimg(:,:,i)=mask(:,:,i).*img(:,:,i);
end

%% Do the interpolation

[m n dim]=size(rawimg);
newimg=zeros(size(rawimg));

%Band 1 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(1:2:end,1:2:end,1);
temp1=BTESonestep(temp,1,1,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,1,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,1)=temp+temp1;

%Band 2 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(1:2:end,1:2:end,2);
temp1=BTESonestep(temp,1,1,'odd');
b2=temp+temp1;
b2=upsample(upsample(b2',2)',2);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 2.
temp=BTESonestep(b2,1,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,2)=temp+temp1;


%Band 3 interpolation
temp=BTESonestep(rawimg(:,:,3),2,2,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,3)=temp+temp1;
  
%Band 4 interpolation
temp=BTESonestep(rawimg(:,:,4),1,2,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,4)=temp+temp1;

%Band 5 interpolation
temp=BTESonestep(rawimg(:,:,5),2,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,5)=temp+temp1;
  


%%  
%Now just calculate rms error but before that
%it is mandatory to convert image to uint8. 
%img=im2uint8(img);
%newimg=im2uint16(newimg);
% [rmse psnr]=RMSE(double(img),double(newimg),10)
% %[rmse psnr]=RMSE(img,newimg,0)
% 
% for i=1 :dim
%     img(:,:,i)=histeq(img(:,:,i));
%     newimg(:,:,i)=histeq(newimg(:,:,i));
% end
% imshow(img(:,:,[4 3 2]))
% figure,imshow(newimg(:,:,[ 4 3 2]))
% 
