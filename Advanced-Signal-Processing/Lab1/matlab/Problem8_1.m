% Problem8.1
dt = 1/100;
et = 4;
t = 0:dt:et;
y = square(2*pi*t);
subplot(2,1,1);plot(t,y);grid on
axis([0 et -2 2]);
xlabel('Time(s)');
ylabel('X');
[f,s] = ft(t,y);
S = abs(s);
subplot(2,1,2);
plot(f,S);grid on
xlabel('Frequency(Hz)');
ylabel('Amplitude');