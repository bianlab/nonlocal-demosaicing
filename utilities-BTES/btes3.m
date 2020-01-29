% This function takes input as original 3band image
%then makes raw image and then returns original and reconstructed image.
%'newimg' variable will have interpolated image
function [newimg img]=btes3(img)
%make the image size even
img=img(1:floor(size(img,1)/2)*2,1:floor(size(img,2)/2)*2,:);
[m, n, ~]=size(img) ;%redefine variables m, n , dim

%make the template for mask required for creating raw image

temp(:,:,1)=[1 0; 0 0]; %red  mask 
temp(:,:,2)=[0 1; 1 0]; %green mask
temp(:,:,3)=[0 0; 0 1]; %blue mask

mask=zeros(size(img));
rawimg=zeros(size(img)); 
%this varibale 'rawimg' will have values only from one band and rest zeros.
for i=1:3
    mask(:,:,i)=repmat(temp(:,:,i),m/2,n/2);
end

%multiply the mask wih individual bands to get band values at specific
%points such that rawimg have individual band values.
for i=1:3
    rawimg(:,:,i)=mask(:,:,i).*img(:,:,i);
end
%At this point in the 'rawimg' there are
%% Do the interpolation
newimg=zeros(size(rawimg));

%Please read the author's paper for the explaination of these steps.
%BTESonestep is the function to apply algorithm on each pixel.

%firstly do level 1 interpolation of green band
temp=BTESonestep(rawimg(:,:,2),1,2,'odd');
newimg(:,:,2)=rawimg(:,:,2)+temp;

%Now we do red band interpolation  
temp=BTESonestep(rawimg(:,:,1),1,1,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,1)=temp+temp1;
  
%Now do the blue band interpolation
temp=BTESonestep(rawimg(:,:,3),2,2,'even');
temp1=BTESonestep(temp,1,1,'odd');
newimg(:,:,3)=temp+temp1;


