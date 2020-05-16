% Task2 PSNR function
function [PSNR] = PSNR1(im_1,im_2)
%im_1 = imread('iamgename1.***');
%im_2 = imread('iamgename2.***');
im1 = double(im_1);
im2 = double(im_2);
[r1,c1] = size(im1);
[r2,c2] = size(im2);
t = 0;
if (r1 == r2 && c1 == c2)
    for i=1:r1
        for j=1:c2
            t=t+(im1(i,j)-im2(i,j))^2;
        end
    end
end
mse = t/(r1 * c1);
PSNR = 10*log10(255^2/mse);
end

