%Task1
%% i set reference
im = imread('lenna512.bmp');
%% ii Add Gaussion white nosie
im_wn = addGWN(im,10);% Add Gaussian white noise with zero mean and variance 10 to the image im;
figure;
subplot(1,2,1);imshow(im);title('Orignal Image');
subplot(1,2,2);imshow(uint8(im_wn));title('Image with Gaussian white noise');
truesize;
%% iii Add salt & pepper noise with noise density 10%
im_SP = addSPN(im,0.1);
figure;
subplot(1,2,1);imshow(im);title('Orignal Image');
subplot(1,2,2);imshow(uint8(im_SP));title('Image with salt & pepper noise');
truesize;
%% iv Evaluate the PSNR
im_low_dynamic_range = imread('lenna512_low_dynamic_range.bmp');
PSNR_wn = PSNR1(im,im_wn);
PSNR_SP = PSNR1(im,im_SP);
PSNR_low = PSNR1(im,im_low_dynamic_range);
%% v Histogram of all the previous images
figure
subplot(2,2,1);imhist(im);title('Histogram of Orignal Image');
subplot(2,2,2);imhist(uint8(im_wn));title('Histogram of Image with WGN');
subplot(2,2,3);imhist(uint8(im_SP));title('Histogram of Image with SPN');
subplot(2,2,4);imhist(im_low_dynamic_range);title('Histogram of Image with low dynamic range');
%% vi remove noise by the technique of Image Averaging
im_wn10 = Average(im,10);% average 10 images
im_wn100 = Average(im,100);% average 100 images
im_wn1000 = Average(im,1000);% average 1000 images
PSNR_wn10 = PSNR1(im,im_wn10);
PSNR_wn100 = PSNR1(im,im_wn100);
PSNR_wn1000 = PSNR1(im,im_wn1000);