%Task4 Recognizing an employee from his/her image;
im = imread('find_id.jpg');
load('data_for_labC.mat');
ID = get_employees_ID_from_DB_new(im,employees_DB,eignfaces_blk,5);