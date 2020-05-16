% Task1_4 binary image
Im = imread('lenna512color.bmp');
Im_binary = im2bw(Im);
subplot(1,2,1);imshow(Im);title('Original imange');
subplot(1,2,2);imshow(Im_binary);title('Imange of binary level');
truesize;