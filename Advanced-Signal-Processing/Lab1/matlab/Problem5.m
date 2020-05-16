%Problem5
clear
clc
% (b)
dt = 0.01; 
st = -2;
et = 2;
t = st:dt:et;
for t=st:dt:et
plot(t,rect(t),'.b');
hold on;
end
axis([-3 3 -2 2])
xlabel('t');
ylabel('rect(t)');