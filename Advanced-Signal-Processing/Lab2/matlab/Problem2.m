% Problem 2 transmit pulse
clc;clear;close all;
Ts=0.002;
T0=Ts/9;
t=0:T0:Ts;
p=rect((t-Ts/2)/Ts);
stem(t,p,'filled','k-.');
title('Transmit pulse ¨C 10 sample points per symbol period');
axis([-0.0005 0.0025 -0.5 1.5])
xlabel('time t');
ylabel('p(t)');grid on;