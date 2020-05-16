function [value] = rect(t)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
if abs(t)<=0.5
    value=1;
else
    value=0;
end
