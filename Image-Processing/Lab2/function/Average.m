function [im_ave] = Average(im,n)
%Image with Gaussian white noise added, superimposed n times and averaged;
[r,c] = size(im);
im_ave = double(zeros(r,c));
for n=1:n
    im_noise=addGWN(im,n);%add Gaussion white nosie
    im_ave=im_ave+double(im_noise); %sum up
end
im_ave = im_ave/n;%averaged
im_ave = uint8(im_ave);
end

