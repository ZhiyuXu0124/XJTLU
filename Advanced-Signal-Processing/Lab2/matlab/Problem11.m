%Prblem 11 Add GWN
clc;clear;close all;
%% 4ASK mapping
b=[0 0 0 1 1 1 1 0];%input
a=fourASK(b);
%% modulator
Ts=0.002;T0=Ts/10;
t=0:T0:Ts*(length(a)+1);
x=modu(a,Ts,t);
%% add GWN
varinoise=1;
y = x+sqrt(varinoise)*randn(size(x));
%% after receive filter
p = @(t) rect((t-Ts/2)/Ts);
tp = 0:T0:Ts;
h = p(Ts-tp);                    
z = T0/Ts * conv(y,h);               
tz = T0*(0:length(z)-1);
%% sample
ts = Ts:Ts:(length(a)+2)*Ts;
zs = z(Ts/T0+1:Ts/T0:end);
%% plot
subplot(4,1,1);
stem(t,x,'fill','k-.'); grid on;
title('Transmit signal x(t)');xlabel('t');ylabel('x(t)');
subplot(4,1,2);
stem(t,y,'fill','k-.'); grid on;
title('noisy receive signal y(t)');xlabel('t');ylabel('y(t)');
subplot(4,1,3);
stem(tz,z,'fill','k-.'); grid on;
title('signal out of matched filter z(t)');xlabel('t');ylabel('z(t)');
subplot(4,1,4);
stem(ts,zs,'fill','k-.'); grid on;
title('downsample zk(t)'); xlabel('time t');ylabel('zk(t)');