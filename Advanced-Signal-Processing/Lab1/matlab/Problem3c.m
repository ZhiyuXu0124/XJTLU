%Problem3c
clear
clc
dt = 0.01; 
et = 2.5;
t = 0:dt:et;
x = exp(1j*2*pi*t);
y = real(x);
z = imag(x);
plot3(y,z,t);
xlabel('real part');
ylabel('imaginary part');
zlabel('t');