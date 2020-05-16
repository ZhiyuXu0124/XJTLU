function [z] = DB(zk)
%Decision block;
z = [1;1;1;1]*zk;
z_standard = [4;2;-2;-4]*ones(1,length(zk));
z_distance = abs(z -z_standard);
[~,N] = min(z_distance);
z = z_standard(N);
end