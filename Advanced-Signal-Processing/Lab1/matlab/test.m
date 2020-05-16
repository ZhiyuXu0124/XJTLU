T0 = 2;
f0 = 1/T0;
Ts = T0/10;
st = -10*T0;
et = 10*T0;
t = st:dt:et;
y = sinc(f0*t);
plot(t,y)