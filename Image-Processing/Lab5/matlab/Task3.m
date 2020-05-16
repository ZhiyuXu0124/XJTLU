% Task3 Car License Plate Recognition (2)
%% binarize the license plate and the alphanumeric template images
im_CLP_original = imread('car_license_plate.bmp');
im_CLP = rgb2gray(im_CLP_original);
im_AT_original = imread('alphanumeric_templates .bmp');
im_AT_reversed = imcomplement(rgb2gray(im_AT_original));
im_CLP_binarized = imbinarize(im_CLP,'adaptive','Sensitivity',0.2);
im_AT_binarized = imbinarize(im_AT_reversed,0.2);
%% Character detection
im_CLP_binarized = imdilate(im_CLP_binarized,ones(1,3));
str = detect_car_license_plate_v2(im_CLP_binarized,im_AT_binarized);