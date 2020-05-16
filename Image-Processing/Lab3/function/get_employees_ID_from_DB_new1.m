function [ID] = get_employees_ID_from_DB_new1(im,employees_DB,eignfaces_blk,Threshold)
%Recognizing an employee from his/her image;
%By calculating the Euclidean distance of the known weights of face and 
%each weights in the database; The ID corresponding to the smallest weights
%distance is the ID that is found;
im_new = medfilt2(im,[5 5]);%add 5X5 median filter
weights_of_face = get_face_weights(im_new,eignfaces_blk);
[~,m] = size(employees_DB);
Euclidean_distance = zeros(1,m);
for i = 1:m
    Euclidean_distance(i)=norm(weights_of_face-employees_DB(i).weights);
end
A = Euclidean_distance==min(Euclidean_distance);
B = min(Euclidean_distance);
%set threshold;
if B < Threshold
    ID = employees_DB(A).id;
else
    ID = 0;
    disp('Warning!! face recognition error!');
end
end

