function array = find_edge2(input)
[~,c] = size(input);
temp = input(1);
array = zeros(1,12);
n = 1;
for i = 1:c
    if ((temp~=input(i))&&((temp==0)||(input(i)==0)))
        array(n) = i;
        n = n + 1;
    end
    temp = input(i);
end
end