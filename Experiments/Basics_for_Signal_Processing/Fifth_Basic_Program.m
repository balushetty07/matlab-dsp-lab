clc;
clear;
close all;

Fs = 1000;
t = 0:1/Fs:0.05;
f = 100;
x = sin(2*pi*f*t);

plot(t,x,'LineWidth',1.2);
grid on;
title('Sampled Sinusoidal Signal');
xlabel('Time (s)');
ylabel('Amplitude');