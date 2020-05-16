%Task4 Apply the median filter with a 3X3 window and a 5X5 window on the
%image im_SP;

im = imread('lenna512.bmp');
im_SP = addSPN(im,0.1);%Add salt & pepper noise with noise density 10%
%% Median filter by 3X3 and 5X5
im_MF_3X3 = medfilt2(im_SP,[3 3]);
im_MF_5X5 = medfilt2(im_SP,[5 5]);
PSNR_MF_3X3 = PSNR1(im,im_MF_3X3);
PSNR_MF_5X5 = PSNR1(im,im_MF_5X5);
figure(1)
subplot(2,2,1);imshow(im);title('Original Image');
subplot(2,2,2);imshow(uint8(im_SP));title('Image with salt & pepper noise');
subplot(2,2,3);imshow(im_MF_3X3);title('Image of 3X3 Median filter');
subplot(2,2,4);imshow(im_MF_5X5);title('Image of 5X5 Median filter');
truesize;
%% Average filter by 3X3
h = fspecial('average',[3,3]);%create an averaging filter h of 3X3 size;
im_AF_3X3 = imfilter(im_SP,h);
PSNR_AF_3X3 = PSNR1(im,im_AF_3X3);
figure(2)
subplot(1,3,1);imshow(im);title('Original Image');
subplot(1,3,2);imshow(uint8(im_SP));title('Image with salt & pepper noise');
subplot(1,3,3);imshow(im_AF_3X3);title('3X3 Average filter Image');
truesize;