%Task5 Discuss the robustness
im_OG = imread('find_id.jpg');
load('data_for_labC.mat');
%% Adding Gaussian Withe noise
im_GWN1 = imnoise(im_OG, 'gaussian', 0, 10^2/255^2); 
im_GWN2 = imnoise(im_OG, 'gaussian', 0, 500^2/255^2);
%% Adding Salt & Pepper noise
im_SP1 = imnoise(im_OG, 'salt & pepper',0.2);
im_SP2 = imnoise(im_OG, 'salt & pepper',0.65);
%% Get employees ID
ID = get_employees_ID_from_DB(im_OG,employees_DB,eignfaces_blk);
ID_GWN1 = get_employees_ID_from_DB_new(im_GWN1,employees_DB,eignfaces_blk,5);
ID_GWN2 = get_employees_ID_from_DB_new(im_GWN2,employees_DB,eignfaces_blk,5);
ID_SP1 = get_employees_ID_from_DB_new(im_SP1,employees_DB,eignfaces_blk,5);
ID_SP2 = get_employees_ID_from_DB_new(im_SP2,employees_DB,eignfaces_blk,5);
%% Get employees ID(with filter)
ID_SP1_filter = get_employees_ID_from_DB_new1(im_SP1,employees_DB,eignfaces_blk,5);
ID_SP2_filter = get_employees_ID_from_DB_new1(im_SP2,employees_DB,eignfaces_blk,5);
%% Plot images
figure(1)
subplot(1,3,1);imshow(uint8(im_OG));title('Original Image');
subplot(1,3,2);imshow(uint8(im_GWN1));title('Image with GWN1');
subplot(1,3,3);imshow(uint8(im_GWN2));title('Image with GWN2');
truesize;
figure(2)
subplot(1,3,1);imshow(uint8(im_OG));title('Original Image');
subplot(1,3,2);imshow(im_SP1);title('Image with S&P noise 1');
subplot(1,3,3);imshow(im_SP2);title('Image with S&P noise 2');
truesize;