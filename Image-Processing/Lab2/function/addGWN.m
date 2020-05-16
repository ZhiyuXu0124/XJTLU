function distImg = addGWN(origImg,p)
%UNTITLED Adding white Gaussian(mean=0,variance=p) noise to the original
%image;
% function WGN (m, n, p) produces a matrix of Gaussian white noise in M rows and N columns; 
% P specifies the intensity of the output noise in W units(variance);
% code need change unit, Formula is P(dB)=10lgP(W);
distImg = double(origImg) + wgn(size(origImg,1),size(origImg,2),10*log10(p*p));
end

