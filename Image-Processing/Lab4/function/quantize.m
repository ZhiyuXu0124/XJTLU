function [im_out] = quantize(im_in,QP)
%this function is to quantize each 8 X 8 block using the following formula;
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
f1 = @(block_struct)dct2(block_struct.data);
f2 = @(block_struct)round((block_struct.data)./(Qmat*S));
f3 = @(block_struct)(sum(sum((block_struct.data).*B)));
im = blockproc(im_in,[8 8],f1);
im_out = blockproc(im,[8 8],f2);
im_out = blockproc(im_out,[8 8],f3);
end

