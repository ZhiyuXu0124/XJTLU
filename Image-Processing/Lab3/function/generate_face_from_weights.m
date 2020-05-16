function[im]=generate_face_from_weights(weights_of_face,eigenfaces_blk)
%Face generation from its ¡°weights;
%Superimpose the product of the weights of eigenfaces and eigenfaces to get
%the original image;
[m,n,l]=size(eigenfaces_blk);
im=zeros(m,n);
im=double(im);
for i=1:l
im=im+weights_of_face(1,i)*eigenfaces_blk(:,:,i);
end
im=uint8(im);
end

