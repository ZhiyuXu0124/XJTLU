function [f,S] = ft(t,s)

% Compute Fourier transform S(f) of signal s(t).
%
% Usage:
% [f,S] = ft(t,s)
%
% Inputs:  time vector t and signal vector s.
% Outputs: frequency vector f and spectrum vector S.
%
% Comment: The spectrum is scaled such that 
%
%   Ts*norm(s)^2 = fs * norm(S)^2 = E
%
% where Ts is the spacing of the time vector, fs is the spacing of
% the frequency vector, and E is the energy of the underlying continous
% time signal that is sampled by s.  This scaling gives the right intuition
% from the plot of the spectrum.

% Comments: This is a function to circumvent the confusion with using the
% FFT and to compute the spectrum of signals that are supposed to be
% continuous valued.


if length(t) ~= length(s)
    error('t and s must have same length')
end

% determine time parameters: 
% number of samples, sampling period and total duration 
no_t  =  length(t);
Ts    =  t(2) - t(1);
Ta    =  t(end) - t(1);

% compute frequency points
f     =  1/Ta * ( (0:(no_t-1)) - floor(no_t/2) );

% compute spectrum (incl. shift and scaling)
S = fftshift(fft(s)) * Ts;
