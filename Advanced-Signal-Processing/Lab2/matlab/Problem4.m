%Problem4
clc;clear;close all;
Ts = 0.002;
T0 = Ts/9;
t = -2*Ts:T0:6*Ts;
a = [4 2 -2 -4];
p = @(t) rect((t-Ts/2)/Ts);
x1 = a(1)*p(t-1*Ts);
x2 = a(2)*p(t-2*Ts);
x3 = a(3)*p(t-3*Ts);
x4 = a(4)*p(t-4*Ts);
stem(t,x1,'filled','-.');hold on;
stem(t,x2,'filled','-.');hold on;
stem(t,x3,'filled','-.');hold on;
stem(t,x4,'filled','-.');hold on;