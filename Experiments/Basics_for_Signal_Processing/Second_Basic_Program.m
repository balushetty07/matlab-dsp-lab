clc;
clear;
close all;

n = -10:10;

impulse = (n == 0);
step = (n >= 0);
ramp = n .* (n >= 0);

figure;
subplot(3,1,1);
stem(n, impulse, 'filled');
grid on;
title('Unit Impulse Signal');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,2);
stem(n, step, 'filled');
grid on;
title('Unit Step Signal');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,3);
stem(n, ramp, 'filled');
grid on;
title('Unit Ramp Signal');
xlabel('n'); ylabel('Amplitude');
