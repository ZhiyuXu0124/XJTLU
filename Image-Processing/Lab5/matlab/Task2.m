% Task2 Car License Plate Recognition (1)
%% binarize the license plate and the alphanumeric template images
im_CLP_original = imread('car_license_plate.bmp');
im_CLP = rgb2gray(im_CLP_original);
im_AT_original = imread('alphanumeric_templates .bmp');
im_AT_reversed = imcomplement(rgb2gray(im_AT_original));
im_CLP_binarized = imbinarize(im_CLP,'adaptive','Sensitivity',0.2);
im_AT_binarized = imbinarize(im_AT_reversed,0.2);
figure(1)
subplot(2,1,1);imshowpair(im_CLP_original,im_CLP_binarized,'montage');title('Car license plate');
subplot(2,1,2);imshowpair(im_AT_original,im_AT_binarized,'montage');title('Alphanumeric templates');
%% Character detection
im_CLP_binarized = imdilate(im_CLP_binarized,ones(1,3));
str = detect_car_license_plate_v1(im_CLP_binarized,im_AT_binarized);