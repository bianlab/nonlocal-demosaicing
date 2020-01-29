%Implementation of BTES algorithm of paper "binary tree-based generic
%demosaicking algorithm for multispectral filter arrays" by Lidan Miao.
%Vol 15 No. 11 Nov 2006, Transactions on image processing

% This program is for 4 band multispectral images.
function [newimg img]=btes4(img,mask)
%clc; clear all; close all;

%read a multispectral image of four bands
%m=1829;n=2034;dim=6; 
%m=1754;n=1653;dim=4;
%img=multibandread('MultispectralData\img1999',[ m n dim],...
%                        'uint8=>uint8',0,'bsq','ieee-le');
% for i=1 :dim
%     img(:,:,i)=histeq(img(:,:,i));
% end

%img=randi(255,15,14,4);
%make no.of rows and cols as multiple of 4 so that
% we can apply filters 
% img=im2double(img(1000:1500,1000:1500,[3 4 5 6]));
img=img(1:floor(size(img,1)/4)*4,1:floor(size(img,2)/4)*4,:);
[m n dim]=size(img) ;%redefine variables m, n , dim
%imshow(img(:,:,[4 3 2 ])); %img is in double

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%make the template for mask
rawimg=zeros(size(img));
%multiply the mask wih individual bands to get band values at specific
%points such that rawimg have individual band values.
for i=1:4
    rawimg(:,:,i)=mask(:,:,i).*img(:,:,i);
end

%% Do the interpolation


%Rotate band 2, for that make it divisible by two;
[m n dim]=size(rawimg);
% rawimg=rawimg(1:floor(m/2)*2,1:floor(n/2)*2,:);
% rotated=BTESrotate45(rawimg(:,:,2),1,2);
% rawimg=rawimg(1:floor(m/7)*7,1:floor(n/7)*7,:);
% rotated=rotated(1:floor(m/7)*7,1:floor(n/7)*7,:);

%here we have done interpolation for individual pixel
%and in binary tree we will reach from level 2 to 1
newimg=zeros(size(rawimg));
newimg1=zeros(size(rawimg));

temp=BTESonestep(rawimg(:,:,1),1,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,1)=temp+temp1;
  
%Now do the blue band interpolation
temp=BTESonestep(rawimg(:,:,2),1,2,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,2)=temp+temp1;

temp=BTESonestep(rawimg(:,:,3),2,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,3)=temp+temp1;
  
%Now do the blue band interpolation
temp=BTESonestep(rawimg(:,:,4),2,2,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,4)=temp+temp1;


%%
%img=im2uint8(img);
%newimg=im2uint16(newimg);
% [rmse,psnr]=RMSE(double(img),double(newimg),10)
% 
% for i=1 :dim
%     img(:,:,i)=histeq(img(:,:,i));
%     newimg(:,:,i)=histeq(newimg(:,:,i));
% end
% imshow(img(:,:,[4 3 2]))
% figure,imshow(newimg(:,:,[4 3 2]))
% 
% 

