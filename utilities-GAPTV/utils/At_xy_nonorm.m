function  y = At_xy_nonorm(z, Phi)
%z = z./Phi_sum;   
y = bsxfun(@times, z, Phi);
% % imshow(y(:,:,1))

end