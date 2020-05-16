function [weights_of_face] = get_face_weights(im, eigenfaces_blk)
%Evaluating the Eigenfaces weights of a face(im)
%The weights of the feature quantity is obtained by separately
%calculating the coefficient of the measured image and each eigenfaces;
[n,m,l]=size(eigenfaces_blk);
weights_of_face=zeros(1,l);
im=double(im);
for i=1:l
weights_of_face(1,i)=sum(sum(im.*eigenfaces_blk(:,:,i)))/(m*n);
end
end