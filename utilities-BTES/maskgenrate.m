%make the template for mask
function [mask] = maskgenrate(m,n)

% m = 128;
% n = 128;
%%
mask = zeros(m,n);
%% 1/16 [1 0;1 0]
temp = [1 0 0 0;0 0 0 0; 0 0 0 0 ; 0 0 0 0];
mask(:,:,1)=repmat(temp,m/4,n/4);
temp = [0 0 0 0;0 0 0 0; 0 0 1 0 ; 0 0 0 0];
mask(:,:,2)=repmat(temp,m/4,n/4);
%% 1/8 [1 0;1 0]
temp = [0 0 1 0;0 0 0 0; 1 0 0 0; 0 0 0 0];
mask(:,:,3)=repmat(temp,m/4,n/4);
%% 1/8 [0 1;0 0]
temp = [0 1 0 0;0 0 0 0; 0 0 0 1 ; 0 0 0 0];
mask(:,:,4)=repmat(temp,m/4,n/4);
temp = [0 0 0 1;0 0 0 0; 0 1 0 0 ; 0 0 0 0];
mask(:,:,5)=repmat(temp,m/4,n/4);
%% 1/8 [0 0;1 0]
temp = [0 0 0 0;1 0 0 0; 0 0 0 0 ; 0 0 1 0];
mask(:,:,6)=repmat(temp,m/4,n/4);
temp = [0 0 0 0;0 0 1 0; 0 0 0 0 ; 1 0 0 0];
mask(:,:,7)=repmat(temp,m/4,n/4);
%% 1/8 [0 0;0 1]
temp = [0 0 0 0;0 1 0 0; 0 0 0 0 ; 0 0 0 1];
mask(:,:,8)=repmat(temp,m/4,n/4);
temp = [0 0 0 0;0 0 0 1; 0 0 0 0 ; 0 1 0 0];
mask(:,:,9)=repmat(temp,m/4,n/4);

% for i = 1:9
%     if i==1
%         t = mask(:,:,i);
%     else
%         t = mask(:,:,i) + t;
%     end
% end