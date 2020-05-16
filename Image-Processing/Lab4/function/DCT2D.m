function [im_output] = DCT2D(im_input)
%This function is to do the 2D DCT of all the 8X8 non-overlapping blocks of
%the image im_input, and merge the left-top pixel of all blocks after the
%DCT transformation to get a smaller image im_output;
B =[1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;];
f1 = @(block_struct)dct2(block_struct.data);
f2 = @(block_struct)(sum(sum((block_struct.data).*B)));
im = blockproc(im_input,[8 8],f1);
im_output = blockproc(im,[8 8],f2);
end

