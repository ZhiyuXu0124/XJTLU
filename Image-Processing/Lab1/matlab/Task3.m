%% Task3_1 Down-sampling by using mean value;
I0 = imread('lenna512.bmp');
foo = @(mat) mean(mat.data,'all');
I1 = blockproc(I0,[2 2],foo);
[r0,c0] = size(I0);
[r1,c1] = size(I1);
figure(1)
subplot(1,2,1);imshow(I0),title(['Original','(',num2str(r0),'*',num2str(c0),')']);
subplot(1,2,2);imshow(uint8(I1)),title(['Down-sampling','(',num2str(r1),'*',num2str(c1),')']);
truesize;
%% Task3_2  Up-sampling by using nearest neighbor interpolation;
N = 2; %the 'N' is magnification;
I2 = zeros(N*r1,N*c1);
for i=1:r1*N
    for j=1:c1*N
        r2=round(i/N);
        c2=round(j/N);
        I2(i,j)=I1(r2,c2);
    end
end
[r3,c3]=size(I2);
figure(2);
subplot(1,2,1);imshow(uint8(I1)),title(['Down-sampling','(',num2str(r1),'*',num2str(c1),')']);
subplot(1,2,2);imshow(uint8(I2)),title(['Up-sampling','(',num2str(r3),'*',num2str(c3),')']);
truesize;
%% Task3_3 Up-sampling by using bilinear interpolation and bicubic interpolation;
I3 = imresize(I1,2,'bilinear');
I4 = imresize(I1,2,'bicubic');
[r4,c4] = size(I3);
[r5,c5] = size(I4);
figure(3);
subplot(1,3,1);imshow(uint8(I1)),title(['Down-sampling','(',num2str(r1),'*',num2str(c1),')']);
subplot(1,3,2);imshow(uint8(I3)),title(['Up-sampling by bilinear interpolation','(',num2str(r4),'*',num2str(c4),')']);
subplot(1,3,3);imshow(uint8(I4)),title(['Up-sampling by bicubic interpolation','(',num2str(r5),'*',num2str(c5),')']);
truesize;
%% Task3_4 Calculate the psnr;
% Useing PSNR1 function in task2;
PSNR_N0   = PSNR1(I0,I2);%Nearest;
PSNR_Bil0 = PSNR1(I0,I3);%Bilinear;
PSNR_Bic0 = PSNR1(I0,I4);%Bicubic;
% Useing matlab function;
PSNR_N   = psnr(I0,uint8(I2));%Nearest;
PSNR_Bil = psnr(I0,uint8(I3));%Bilinear;
PSNR_Bic = psnr(I0,uint8(I4));%Bicubic;