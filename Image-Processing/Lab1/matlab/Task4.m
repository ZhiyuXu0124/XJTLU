%% Task4 256 gray level to 16 gray level by quantization
im_256 = imread('lenna512.bmp');
[r,c] = size(im_256);
im_16 = zeros(r,c);
for i = 1:r
    for j = 1:c
        im_16(i,j) = floor(im_256(i,j)/16);%rounding
    end
end
subplot(1,2,1);imshow(im_256),title('Original Imange');colorbar;
subplot(1,2,2);imshow(uint8(im_16),[0,15]),title('Quantized Imange');colorbar;
