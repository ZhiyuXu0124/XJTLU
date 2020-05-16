im_OG = imread('find_id.jpg');
load('data_for_labC.mat');
im_SP2 = imnoise(im_OG, 'salt & pepper',0.65);
%ID_SP2 = get_employees_ID_from_DB(im_SP2,employees_DB,eignfaces_blk);
weights_of_face = get_face_weights(im_SP2,eignfaces_blk);
[~,m] = size(employees_DB);
Euclidean_distance = zeros(1,m);
for i = 1:m
    Euclidean_distance(i)=norm(weights_of_face-employees_DB(i).weights);
end
A = Euclidean_distance == min(Euclidean_distance);
B = min(Euclidean_distance);
if B < 5
    ID = employees_DB(A).id;
else
    ID = 0;
    %disp('Warning!! face recognition error!');
end
