%Task1 calculating the entropy of images
%% (1)&(2)
img = imread('lenna512.bmp');
foo = @(mat)mean(mat.data,"all");
img_half = blockproc(img,[2 2],foo);%reduce the original image to half size;
img_half = uint8(img_half);
img_16_gray_level = floor(img/16);%change 265 gray level to 16 gray level;
entropy_OGimg = Entropy(img);
entropy_half_OGimg = Entropy(img_half);
entropy_img_16 = Entropy(img_16_gray_level);
%% (3) DPCM (differential pulse code modulation)
[im_DPCM_e,im_DPCM_p] = DPCM(img);
subplot(1,2,1);imshow(img);title('Original Image');
subplot(1,2,2);imshow(im_DPCM_e,[]);title('Processed Image');
truesize;
entropy_img_DPCM_e = Entropy(im_DPCM_e);