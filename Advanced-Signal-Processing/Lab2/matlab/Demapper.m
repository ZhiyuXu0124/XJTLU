function [b] = Demapper(zk)
b=zeros(length(zk),2);           % initialize the matrix [k,2] 
b(:,1)=~(sign(zk)+1);            % get the first bit
b(:,2)=~(zk-2*sign(zk));         % get the second bit
b=reshape(b',1,2*length(zk),[]); % reshape to [1,2k] matrix
end