% Task(1) show RGB
Im = imread('lenna512color.bmp');
null = zeros(512,512);
subplot(2,2,1),imshow(Im),title('Original imange');
subplot(2,2,2),imshow(cat(3,Im(:,:,1),null,null)),title('Imange of R');
subplot(2,2,3),imshow(cat(3,null,Im(:,:,2),null)),title('Imange of G');
subplot(2,2,4),imshow(cat(3,null,null,Im(:,:,3))),title('Imange of B');
truesize;