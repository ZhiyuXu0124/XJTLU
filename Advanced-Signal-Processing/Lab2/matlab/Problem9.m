%Problem 9.1
clc;clear;close all;
Ts = 0.002;
T0 = Ts/10;
t = 0:T0:6*Ts;
a = [4 2 -2 -4];
p = @(t) rect((t-Ts/2)/Ts);
y1 = a(1).*p(t-1*Ts);
y2 = a(2).*p(t-2*Ts);
y3 = a(3).*p(t-3*Ts);
y4 = a(4).*p(t-4*Ts);
th = 0:T0:Ts;
h = p(Ts-th);
z1 = T0/Ts * conv(y1,h);
z2 = T0/Ts * conv(y2,h);
z3 = T0/Ts * conv(y3,h);
z4 = T0/Ts * conv(y4,h);
tz1 = T0 * (0:(length(z1)-1));
plot(tz1, z1,'DisplayName','z1(t)');hold on;
plot(tz1, z2,'DisplayName','z2(t)');hold on;
plot(tz1, z3,'DisplayName','z3(t)');hold on;
plot(tz1, z4,'DisplayName','z4(t)');hold off;
axis([0.0018 0.0122 -4 4])
legend