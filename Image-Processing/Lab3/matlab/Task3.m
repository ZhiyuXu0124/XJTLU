%Task3 Face generation from its ¡°weights";
im_OG=imread('find_id.jpg');
load('data_for_labC.mat');
weights_of_find_id=get_face_weights(im_OG,eignfaces_blk);
im=generate_face_from_weights(weights_of_find_id,eignfaces_blk);
PSNR=psnr(im,im_OG);
subplot(1,2,1);imshow(im_OG);title('Original Image');
subplot(1,2,2);imshow(im);title('Generated Image from weights');
truesize;