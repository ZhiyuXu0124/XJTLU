%Task2 Evaluating the Eigenfaces weights of a face;
im=imread('find_id.jpg');
load('data_for_labC.mat');
weights_of_find_id=get_face_weights(im,eignfaces_blk);
plot(weights_of_find_id,'k');grid on;
title("weights of find id.jpg");
xlabel('Eigenfaces No.');ylabel('Weights of face');
