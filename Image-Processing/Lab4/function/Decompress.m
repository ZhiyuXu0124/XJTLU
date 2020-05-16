function [im_out] = Decompress(im_in,QP)
%Decompress image
Qmat =[16 11 10 16 24 40 51 61;
       12 12 14 19 26 58 60 55;
       14 13 16 24 40 57 69 56;
       14 17 22 29 51 87 80 62;
       18 22 37 56 68 109 103 77;
       24 35 55 64 81 104 113 92;
       49 64 78 87 103 121 120 101;
       72 92 95 98 112 100 103 99;];
B =[1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;];
if (QP>50)
     S= (100-QP)/50;
elseif (QP<=50)
     S= 50/QP;   
end
f1 = @(block_struct)(block_struct.data).*B;
f2 = @(block_struct)round((block_struct.data).*(Qmat*S));
f3 = @(block_struct)idct2(block_struct.data);
im_in = blockproc(im_in,[1 1],f1);
im_out = blockproc(im_in,[8 8],f2);
im_out = blockproc(im_out,[8 8],f3);
end

