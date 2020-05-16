function [out] = Entropy(im)
%Calculating the entropy of an image
%   Detailed explanation goes here
im = uint8(im);
[r,c] = size(im);
count = imhist(im);
p = count/(r*c);
f = @(x) x*log2(1/x);%set entropy function
out = arrayfun(f,p);
%Since there is p=0 in the array, matlab calculates log0 to return NaN, so
%you need to propose NaN value when calculating entropy;
out = sum(out(~isnan(out)));
end

