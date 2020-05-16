%Problem2c
clear
clc
dt = 0.01; 
et = 2;
x1 = 0:dt:et;
x2 = 0:dt:et;
y1 = x1.^2;
y2 = x2.^0.5;
h1=plot(x1,y1,'g');
hold on;
h2=plot(x2,y2,'b');
legend([h1,h2],'y=x^2','y=x^{0.5}');
xlabel('X');
ylabel('Y');