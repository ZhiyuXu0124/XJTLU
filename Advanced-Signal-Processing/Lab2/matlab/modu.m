function [y] = modu(a,Ts,t)
%functiong of modulator
n = 1:length(a);
p = @(t,n)rect((t-(2*n+1)*Ts/2)/Ts);
y = a'*bsxfun(p,t,n');
end