%Problem7
clear
clc
st = -0.3;
et = 0.3;
dt = 0.001;
%% (a)
f1 = 10;
t = st:dt:et;
x1=2*sin(2*pi*f1*t);
h1 = plot(t,x1);
hold on;
%% (b)
h2 = plot(t,2+x1);
hold on; 
%% (c)
f3 = 10*f1;
x3 = sin(2*pi*f3*t);
h3 = plot(t,x3);
hold on;
%% (d)
x4 = x1.*x3;
h4 = plot(t,x4);
legend([h1,h2,h3,h4],'x1(t)','x2(t)','x3(t)','x4(t)')