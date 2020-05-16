%Problem4
clear
clc
f0=10^3;
T0=1/f0;
et = 2*T0;
%% (a)
Ts = T0/10;
t = 0:Ts:et;
y = sin(2*pi*f0*t);
h1 = plot(t,y,'r');
hold on;
%% (b)
Ts2 = T0/20;
t2 = 0:Ts2:et;
y2 = sin(2*pi*f0*t2);
h2 = plot(t2,y2,'k');
hold on;
%% (c)
Ts3 = T0/4;
t3 = 0:Ts3:et;
y3 = sin(2*pi*f0*t3);
h3 = plot(t3,y3,'g');
legend([h1,h2,h3],'Ts = T0/10','Ts2 = T0/20','Ts3 = T0/4');