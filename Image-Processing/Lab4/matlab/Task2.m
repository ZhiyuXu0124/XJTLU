%Task2 Image DCT and quantization
%% (a)Compress image
im = double(imread('lenna512.bmp'));
ims = DCT2D(im);
[r1, c1] =size(im);
[r2, c2] =size(ims);
figure(1)
subplot(1,2,1);imshow(uint8(im));title(['Original Image','(',num2str(r1),'*',num2str(c1),')'])
subplot(1,2,2);imshow(ims,[]);title(['2D DCT 8X8 Image','(',num2str(r2),'*',num2str(c2),')'])
%% (b)Quantization
im_test = quantize(im,80);
figure(2)
subplot(1,2,1);imshow(uint8(im));title('Original Image')
subplot(1,2,2);imshow(uint8(im_test));title('Quantized Image')
%% (c)Decompress image
im_dec = Decompress(im_test,80);
figure(3)
subplot(1,2,1);imshow(uint8(im));title('Original Image')
subplot(1,2,2);imshow(uint8(im_dec));title('Decompressed Image')
%% (d)Decompress image with different QP values
im = double(imread('lenna512.bmp'));
QP = [1 15 29 43 57 71 85 99];
f = @(QP) psnr(uint8(im),uint8(Decompress(quantize(im,QP),QP)));
PSNRS = arrayfun(f,QP);
