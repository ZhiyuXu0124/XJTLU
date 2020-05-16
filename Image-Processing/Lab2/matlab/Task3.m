%Task3 show the horizontal edges, vertical edges and all edges of the image im
im = imread('lenna512.bmp');
im = double(im);
[r,c] = size(im);
im_horizontal_edges = zeros(r,c);
im_vertical_edges = zeros(r,c);
for i = 1:r-2
    for j = 1:c-2
        im_horizontal_edges(i,j)=(im(i+2,j)+2*im(i+2,j+1)+im(i+2,j+2))-(im(i,j)+2*im(i,j+1)+im(i,j+2));
        im_vertical_edges(i,j)=(im(i,j)+2*im(i+1,j)+im(i+2,j))-(im(i,j+2)+2*im(i+1,j+2)+im(i+2,j+2));
    end
end
im_all_edges = edge(im,'sobel');%Sobel edge detection operator
subplot(1,3,1);imshow(uint8(im_horizontal_edges));title('Image of horizontal edges');
subplot(1,3,2);imshow(uint8(im_vertical_edges));title('Image of vertical edges');
subplot(1,3,3);imshow(im_all_edges);title('Image of all edges');
truesize;