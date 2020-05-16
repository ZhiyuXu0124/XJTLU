%Task 1 Determine whether the feature face matrix is an orthogonal matrix
load('data_for_labC.mat');
faces=eignfaces_blk;
[m,n,l]=size(faces);
X=zeros(l,m*n);  
%Reshape the matrix to a 101*135000 matrix
for i=1:l
x=faces(:,:,i);
X(i,:)=reshape(x,1,m*n);
end
%Determine whether the product of the matrix and the transposed matrix is
%an identity matrix;
output_initial=X*X'/(m*n);
output=round(output_initial);
if output == eye(l,l)
    judgment=1; %Orthogonal
else
    judgment=0; %Not orthogonal
end

