%Problem6
clear
clc
T0 = 2;
f0 = 1/T0;
Ts = T0/10;
st = -10*T0;
et = 10*T0;
t = st:Ts:et;
plot(t,sinc(f0*t))
grid on;
xlabel('t');
ylabel('sinc(t)');