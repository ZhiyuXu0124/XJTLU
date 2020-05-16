% Task1_3 gray image
Im = imread('lenna512color.bmp');
Im_gray = rgb2gray(Im);
subplot(1,2,1);imshow(Im);title('Original imange');
subplot(1,2,2);imshow(Im_gray);title('Imange of gray level');
truesize;