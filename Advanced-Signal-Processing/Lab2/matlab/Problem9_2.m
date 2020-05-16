clc;clear;close all;
%% 4ASK mapping
b=[0 0 0 1 1 1 1 0];%input
a=fourASK(b);
%% modulator
Ts=0.002;T0=Ts/10;
t=0:T0:Ts*(length(a)+1);
xt=modu(a,Ts,t);
%% after receive filter
p = @(t) rect((t-Ts/2)/Ts);
y = xt;
tp = 0:T0:Ts;
h = p(Ts-tp);                    
z = T0/Ts * conv(y,h);               
tz = T0*(0:length(z)-1);
stem(tz,z,'fill','k-.'); grid on; 
title('transmit signal for x(t)');
xlabel('t');ylabel('z(t)');