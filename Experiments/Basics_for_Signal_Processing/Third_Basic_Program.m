clc;
clear;
close all;

n = 0:50;
A = 2; 
f = 0.1;

x = A*sin(2*pi*f*n);

stem(n, x, 'filled');
grid on;
title('Discrete-Time Sinusoidal Signal');
xlabel('n');
ylabel('Amplitude');