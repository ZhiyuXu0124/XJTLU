function [e,p] = DPCM(im)
%This function is the weighted average value of the
%neighboring pixels (left, left-top, and top);
im = double(im);
h = [0.2,0.4;0.4,0];%Set filter coefficients;
p = imfilter(im,h,'replicate','same','corr');
e = im-p;
end