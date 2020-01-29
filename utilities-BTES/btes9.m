%Implementation of BTES algorithm of paper "binary tree-based generic
%demosaicking algorithm for multispectral filter arrays" by Lidan Miao.
%Vol 15 No. 11 Nov 2006, Transactions on image processing

% This program is for 9 band multispectral images.
function [newimg,img]=btes9(img,mask)
bnum=9;
img=img(1:floor(size(img,1)/4)*4,1:floor(size(img,2)/4)*4,:);
[m n dim]=size(img) ;%redefine variables m, n , dim

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%make the template for mask
rawimg=zeros(size(img));


%multiply the mask wih individual bands to get band values at specific
%points such that rawimg have individual band values.
for i=1:bnum
    rawimg(:,:,i)=mask(:,:,i).*img(:,:,i);
end

%% Do the interpolation

[m n dim]=size(rawimg);
newimg=zeros(size(rawimg));

%% 1/8 [0 0 0 1;0 0 0 0;1 0 0 0;0 0 0 0]
%Band 3 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(1:2:end,1:2:end,3);
temp1=BTESonestep(temp,1,1,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,1,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,3)=temp+temp1;
%%  1/8 [0 1 0 0;0 0 0 0;0 0 0 1;0 0 0 0]
%Band 4 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(1:2:end,2:2:end,4);
temp1=BTESonestep(temp,1,2,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
temp=b1;
b1(:,1)=0;
b1(1:end,2:end)=temp(1:end,1:end-1);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,1,2,'even');
temp1=BTESonestep(temp,1,2,'odd');
newimg(:,:,4)=temp+temp1;
%%  1/8 [0 0 0 1;0 0 0 0;0 1 0 0;0 0 0 0]
%Band 5 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(1:2:end,2:2:end,5);
temp1=BTESonestep(temp,1,2,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
temp=b1;
b1(:,1)=0;
b1(1:end,2:end)=temp(1:end,1:end-1);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,1,2,'even');
temp1=BTESonestep(temp,1,2,'odd');
newimg(:,:,5)=temp+temp1;
%% 1/8 [0 0 0 0;1 0 0 0;0 0 0 0;0 0 1 0]
%Band 6 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(2:2:end,1:2:end,6);
temp1=BTESonestep(temp,2,1,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
temp=b1;
b1(1,:)=0;
b1(2:end,1:end)=temp(1:end-1,1:end);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,2,1,'even');
temp1=BTESonestep(temp,2,1,'odd');
newimg(:,:,6)=temp+temp1;
%% 1/8 [0 0 0 0;0 0 1 0;0 0 0 0;1 0 0 0]
%Band 7 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(2:2:end,1:2:end,7);
temp1=BTESonestep(temp,2,1,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
temp=b1;
b1(1,:)=0;
b1(2:end,1:end)=temp(1:end-1,1:end);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,2,1,'even');
temp1=BTESonestep(temp,2,1,'odd');
newimg(:,:,7)=temp+temp1;
%% 1/8 [0 0 0 0;0 1 0 0; 0 0 0 0 ; 0 0 0 1];
%Band 8 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(2:2:end,2:2:end,8);
temp1=BTESonestep(temp,2,2,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
temp=b1;
b1(1,:)=0;
b1(:,1)=0;
b1(2:end,2:end)=temp(1:end-1,1:end-1);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,2,2,'even');
temp1=BTESonestep(temp,2,2,'odd');
newimg(:,:,8)=temp+temp1;
%% 1/8 [0 0 0 0;0 0 0 1; 0 0 0 0 ; 0 1 0 0];
%Band 9 interpolation
%firstly do downsampling by 2 and then interpolate
temp=rawimg(2:2:end,2:2:end,9);
temp1=BTESonestep(temp,2,2,'odd');
b1=temp+temp1;
b1=upsample(upsample(b1',2)',2);
temp=b1;
b1(1,:)=0;
b1(:,1)=0;
b1(2:end,2:end)=temp(1:end-1,1:end-1);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,2,2,'even');
temp1=BTESonestep(temp,2,2,'odd');
newimg(:,:,9)=temp+temp1;
%% 1/16 [1 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0]
temp=rawimg(1:2:end,1:2:end,1);
temp1=BTESonestep(temp,1,1,'even');
b1=BTESonestep(temp1,1,1,'odd');
b1=b1+temp1;
b1=upsample(upsample(b1',2)',2);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,1,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,1)=temp+temp1;
%% 1/16 [0 0 0 0;0 0 0 0;0 0 1 0;0 0 0 0]
temp=rawimg(1:2:end,1:2:end,2);
temp1=BTESonestep(temp,2,2,'even');%temp1 ==0???
b1=BTESonestep(temp1,1,1,'odd');
b1=b1+temp1;
b1=upsample(upsample(b1',2)',2);
%now this band 1 have reached level 2 so use that 
%procedure to further interpolate band 1.
temp=BTESonestep(b1,1,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,2)=temp+temp1;
