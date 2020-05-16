% Task1 Morphological operation
im_sawtooth = im2double(imread( 'sawtooth.bmp' ));
im_sawtooth = round(im_sawtooth);
%% (1)Extract the boundary
SE_1 = strel('disk',3);
im_sawtooth_dilate = imdilate(im_sawtooth,SE_1);
im_sawtooth_bundary = xor(im_sawtooth,im_sawtooth_dilate);
figure(1)
subplot(1,3,1);imshow(im_sawtooth);title('Original image')
subplot(1,3,2);imshow(im_sawtooth_dilate);title('Dilated image')
subplot(1,3,3);imshow(im_sawtooth_bundary);title('The boundary of sawtooth.bmp')
%% (2)The operations of erosion, dilation, opening, and closing
SE_2 = strel('disk',15);
im_sawtooth_e = imerode(im_sawtooth,SE_2); % Erosion
im_sawtooth_d = imdilate(im_sawtooth,SE_2); % Dilation
im_sawtooth_o = imopen(im_sawtooth,SE_2); % Opening
im_sawtooth_c = imclose(im_sawtooth,SE_2); % Closing
%Calculate pixels of foreground
Foreground_Numer_Original_image = length(find(im_sawtooth==1));
Foreground_Numer_erision = length(find(im_sawtooth_e==1));
Foreground_Number_dilation = length(find(im_sawtooth_d==1));
Foreground_Number_opening = length(find(im_sawtooth_o==1));
Foreground_Number_closing = length(find(im_sawtooth_c==1));
%plot result
figure(2)
subplot(2,2,1);imshow(im_sawtooth_e);title('Image after erosion');
subplot(2,2,2);imshow(im_sawtooth_d);title('Image after dilation');
subplot(2,2,3);imshow(im_sawtooth_o);title('Image after opening');
subplot(2,2,4);imshow(im_sawtooth_c);title('Image after closing');
%% (3)Repeat the opening operation several times with the same SE
im_sawtooth_o_repeat_50=im_sawtooth_o;
for i=1:49
im_sawtooth_o_repeat_50=imopen(im_sawtooth_o_repeat_50,SE_2);%repeat 50 times
end
%same=1 means after repeating 50 tiomes opening operation, the image
%doesn't change;
if im_sawtooth_o_repeat_50==im_sawtooth_o
    same=1;
else
    same=0;
end
figure(3)
subplot(1,3,1);imshow(im_sawtooth);title('Original image');
subplot(1,3,2);imshow(im_sawtooth_o);title('Image after opening');
subplot(1,3,3);imshow(im_sawtooth_o_repeat_50);title('Image after 50 times opening');