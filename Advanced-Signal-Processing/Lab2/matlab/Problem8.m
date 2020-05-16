%Problem 8 
clc;clear;close all;
Ts=0.002;
t=0:Ts/10:Ts;
P=@(t)rect((t-Ts/2)/Ts);
x=P(t);
h=P(Ts-t);
y=conv(x,h);
ty=0:Ts/10:2*Ts;
figure(1)
stem(t,x,'fill','k-.');title('p(t-Ts)');xlabel('t');ylabel('p(t)');grid on;
figure(2)
stem(t,h,'fill','k-.');title('h(t)');xlabel('t');ylabel('h(t)');grid on;
figure(3)
stem(ty,y,'fill','k-.');title('g(t)');xlabel('t');ylabel('g(t)');grid on;