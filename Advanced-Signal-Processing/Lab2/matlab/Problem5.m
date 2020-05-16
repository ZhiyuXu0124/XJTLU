%Problem 5 
clc;clear;close all;
a=[4; 2; -2; -4];
Ts=0.002;
To=Ts/10;
t=0:To:Ts*(length(a)+1);
xt=modu(a,Ts,t);
stem(t,xt,'fill','k-.');grid on; 
xlabel('t');ylabel('modulated signal');