function [Output] = fourASK(inputArg)
%ak = (1-2bk1)*(4-2bk2);
b=reshape(inputArg,2,[])';
Output= (1-2*b(:,1)).*(4-2*b(:,2)); 
end


