im_CLP_original = imread('car_license_plate.bmp');
im_CLP = rgb2gray(im_CLP_original);
im_AT_original = imread('alphanumeric_templates .bmp');
im_AT_reversed = imcomplement(rgb2gray(im_AT_original));
im_CLP_binarized = imbinarize(im_CLP,'adaptive','Sensitivity',0.2);
im_AT_binarized = imbinarize(im_AT_reversed,0.2);
%% Character detection
im = im_CLP_binarized;
im_SE = im_AT_binarized;
%% Edges detection for car license plate
a = sum(im);
edge1 = find_edge11(a);
%% Edges detection for template
[r,c] = size(im_SE);
f = @(block_struct)sum(block_struct.data);
sumc(:) = blockproc(im_SE,[1 c],f);
sumr(:) = blockproc(im_SE,[r 1],f);
edgec = find_edge22(sumc);
edger = find_edge22(sumr);
edge2 = [edger;edgec];
%% Cut the templates
n = 1;
for i = 1:2:11
    for j = 1:2:11
        temp = imcrop(im_SE,[edge2(1,j),edge2(2,i),edge2(1,j+1)-edge2(1,j),edge2(2,i+1)-edge2(2,i)]);
        vp(n) = libpointer('voidPtr',temp);
        n = n + 1;
    end
end
%% detect symbols
symbols = ['A','B','C','D','E','F',...
           'G','H','I','J','K','L',...
           'M','N','O','P','Q','R',...
           'S','T','U','V','X','Y',...
           'Z','W','1','2','3','4',...
           '5','6','7','8','9','0'];

n = 1;
%for i = 1:36
    test = vp(9).Value;
    SE_1 = imerode(test,ones(1,3));
    SE_2 = imdilate(test,ones(1,3));
    temp = bwhitmiss(im,SE_1,~SE_2);
    s = sum(temp(:,150:420));
    if(sum(s)==1||sum(s)==2)
        for j = 2:1:511
           if (s(j) == 1)
               break;
           end
        end
        out = check(j,edge1+1);
        str(out) = symbols(9);
        disp(str);
    end
%end