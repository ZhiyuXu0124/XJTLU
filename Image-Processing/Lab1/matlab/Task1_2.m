% Task(2) change RGB to HSI
Im = imread('lenna512color.bmp');
rgb=im2double(Im);%change uint8 to double
%Extract imange components;
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);
%RGB to HSI function
num = 0.5*((r - g) + (r - b));
den = sqrt((r - g).^2 + (r - b).*(g - b));
theta = acos(num./(den + eps)); %The "eps":Prevent divisor equal to zero;
%H
H = theta;
H(b > g) = 2*pi - H(b > g);
H = H/(2*pi);
%S
num = min(min(r, g), b);
den = r + g + b;
den(den == 0) = eps; %Prevent divisor equal to zero;
S = 1 - 3.* num./den;
H(S==0)=0;
%I
I = (r+g+b)/3;
subplot(2,2,1);imshow(Im);title('Original imange');
subplot(2,2,2);imshow(H);title('Imange of H');
subplot(2,2,3);imshow(S);title('Imange of S');
subplot(2,2,4);imshow(I);title('Imange of I');
truesize;