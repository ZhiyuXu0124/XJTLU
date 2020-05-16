%Problem3b
clear
clc
dt = 0.01; 
et = 2.5;
t = 0:dt:et;
x = exp(1j*2*pi*t);
real_x=real(x);
imag_x=imag(x);
abs_x=abs(x);
angle_x=angle(x);
figure;
subplot(2,2,1);
plot(t,real_x);title('real part');
subplot(2,2,2);
plot(t,imag_x);title('imaginary part');
subplot(2,2,3);
plot(t,abs_x);title('absolute vaule');
axis([0 et 0 2]);
subplot(2,2,4);
plot(t,angle_x);title('angle');