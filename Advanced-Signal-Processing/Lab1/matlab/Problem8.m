% Problem8
dt = 1/100;
et = 4;
t = 0:dt:et;
x = 2*sin(2*2*pi*t);
subplot(2,1,1);plot(t,x);grid on
axis([0 et -2 2]);
xlabel('Time(s)');
ylabel('X');
[f,s] = ft(t,x);
S = abs(s);
subplot(2,1,2);
plot(f,S);grid on
axis([-10 10 0 10]);
xlabel('Frequency(Hz)');
ylabel('Amplitude');