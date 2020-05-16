%Problem2b
clear
clc
dt = 0.01; 
et = 2;
x = 0:dt:et;
y = x.^0.5;
plot(x,y,'g');