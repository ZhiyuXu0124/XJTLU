function distImg = addSPN(origImg,p)
%UNTITLED Adding salt & pepper noise with noise density p(%) to the
%original image;
%salt & pepper noise: The amplitude of noise is basically the same, but the
%location is random;
[width,height] = size(origImg);
distImg = origImg;
k1=p;              %noise density;
k2=p;              %noise density;
%Rand(M,N) is a matrix that randomly generates M rows and N columns;Each
%matrix element is between 0 and 1;
%So the element less than k is 1 in the matrix, and vice versa is 0;
a1=rand(width,height)<k1;
a2=rand(width,height)<k2;
distImg(a1&a2)=0;           %set black points;
distImg(a1& ~a2)=255;       %set whitre points;
end

