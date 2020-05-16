function [str] = detect_car_license_plate_v1(im,im_SE)
%% Edges detection for car license plate
a = sum(im);
edge1 = find_edge1(a);
%% Edges detection for template
[r,c] = size(im_SE);
f = @(block_struct)sum(block_struct.data);
sumc(:) = blockproc(im_SE,[1 c],f);
sumr(:) = blockproc(im_SE,[r 1],f);
edgec = find_edge2(sumc);
edger = find_edge2(sumr);
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
str(1) =' ';
n = 1;
for i = 1:36
    test = vp(i).Value;
    temp = imerode(im,test);
    s = sum(temp);
    if(sum(s)==1||sum(s)==2)
        for j = 1:1:512
           if (s(j) == 1)
               break;
           end
        end
        out = check(j,edge1);
        str(out) = symbols(i);
    end
end
str = string(str);
end