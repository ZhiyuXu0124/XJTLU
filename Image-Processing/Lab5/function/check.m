function out = check(in,list)
    [~,c] = size(list);
    for i = 1:1:c
       if (in <= list(i))
           break;
       end
    end
    out = i/2;
end