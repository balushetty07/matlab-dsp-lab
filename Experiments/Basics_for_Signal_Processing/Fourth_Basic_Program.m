clc;
clear;
close all;

n = 0:10;
x = n;

x1 = 2*x; % Amplitude scaling
x2 = x + 3; % Amplitude shifting
x3 = fliplr(x); % Time reversal

figure;

subplot(3,1,1);
stem(n,x1,'filled');
grid on;
title('Amplitude Scaling: 2x[n]');

subplot(3,1,2);
stem(n,x2,'filled');
grid on;
title('Amplitude Shift: x[n]+3');

subplot(3,1,3);
stem(n,x3,'filled');
grid on;
title('Time Reversal');