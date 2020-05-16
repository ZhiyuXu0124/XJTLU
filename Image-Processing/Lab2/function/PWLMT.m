function [im_out] = PWLMT(im,a,b,m,n)
%PWLMT is the abbreviation of piece-wise linear mapping transform;
%   The formula changes the gray value of an image by a piecewise linear
%   function;
[r,c] = size(im);
im_out = double(zeros(r,c));
im = double(im);
for i=1:r
    for j=1:c
        if  im(i,j) < m
            im_out(i,j)=round(a/m*im(i,j));
        else if  im(i,j) < n
                im_out(i,j)=round((b-a)/(n-m)*im(i,j)+a-((b-a)/(n-m))*m);
            else im(i,j) < 256;
                im_out(i,j)=round((255-b)/(255-n)*im(i,j)+b-((255-b)/(255-n))*n);
             end
        end
    end
end
im_out = uint8(im_out);
end


