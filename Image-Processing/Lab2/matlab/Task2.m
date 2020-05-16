%Task2 
im = imread('lenna512.bmp');%set reference
%% (1)enhance the contrast of im_low_dynamic_range by piece-wise linear mapping transform
im_low_dynamic_range = imread('lenna512_low_dynamic_range.bmp');
im_enhanced1 = PWLMT(im_low_dynamic_range,20,220,50,200);
im_enhanced2 = PWLMT(im_low_dynamic_range,10,230,50,200);
im_enhanced3 = PWLMT(im_low_dynamic_range,5,250,50,200);
im_enhanced4 = PWLMT(im_low_dynamic_range,10,230,40,210);
im_enhanced5 = PWLMT(im_low_dynamic_range,40,190,60,190);
figure(1)
subplot(2,3,1);imshow(im_low_dynamic_range);title('Image with low dynamic range');
subplot(2,3,2);imshow(im_enhanced1);title('Enhanced Image by piece-wise linear mapping transform 1');
subplot(2,3,3);imshow(im_enhanced2);title('Enhanced Image by piece-wise linear mapping transform 2');
subplot(2,3,4);imshow(im_enhanced3);title('Enhanced Image by piece-wise linear mapping transform 3');
subplot(2,3,5);imshow(im_enhanced4);title('Enhanced Image by piece-wise linear mapping transform 4');
subplot(2,3,6);imshow(im_enhanced5);title('Enhanced Image by piece-wise linear mapping transform 5');
truesize;
% calculate PSNR to the reference image
PSNR_E1 = PSNR1(im,im_enhanced1);
PSNR_E2 = PSNR1(im,im_enhanced2);
PSNR_E3 = PSNR1(im,im_enhanced3);
PSNR_E4 = PSNR1(im,im_enhanced4);
PSNR_E5 = PSNR1(im,im_enhanced5);
%% (2)Use the command histeq 
im_enhanced6 = histeq(im_low_dynamic_range);
figure(2)
subplot(1,2,1);imshow(im_low_dynamic_range);title('Image with low dynamic range');
subplot(1,2,2);imshow(im_enhanced6);title('Enhanced Image by "histeq" function');
truesize;
% calculate PSNR to the reference image
PSNR_E6 = PSNR1(im,im_enhanced6);