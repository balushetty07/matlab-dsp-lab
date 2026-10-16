clc;
clear;
close all;

f = 100;

Fs1 = 1000;
Fs2 = 150;

t1 = 0:1/Fs1:0.05;
t2 = 0:1/Fs2:0.05;

x1 = sin(2*pi*f*t1);
x2 = sin(2*pi*f*t2);

figure;

subplot(2,1,1);
plot(t1,x1);
grid on;
title('Sampling at 1000 Hz');

subplot(2,1,2);
stem(t2,x2,'filled');
grid on;
title('Sampling at 150 Hz');
xlabel('Time (s)');