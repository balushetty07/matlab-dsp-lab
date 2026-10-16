% 5-Panel DSP Analysis Using Built-in Functions
clc; clear; close all;

% --- Computations ---
x = [1 2 3 4 5 6 7 8];
N = length(x);
n = 0:N-1;
k = 0:N-1;

% DFT (Using built-in fft)
X_dft = fft(x);

% DTFT (Using built-in freqz)
w = linspace(0, 2*pi, 1024);
X_dtft = freqz(x, 1, w);

% IDFT (Using built-in ifft)
x_idft = ifft(X_dft);

% IDTFT (Numerical approximation)
dw = w(2) - w(1);
x_idtft = zeros(1, N);

for m = 1:N
    x_idtft(m) = sum(X_dtft(1:end-1) .* ...
        exp(1i * w(1:end-1) * (m-1))) * dw / (2*pi);
end

% --- Plotting ---
figure('Name', 'Signal Analysis', ...
       'Position', [100, 100, 900, 800]);

% 1. Original Signal
subplot(3, 2, [1, 2]);
stem(n, x, 'k', 'filled', 'LineWidth', 1.5);
title('1. Original Signal x(n)');
xlabel('n');
ylabel('Amplitude');
xticks(n);
grid on;

% 2. DFT Magnitude Spectrum
subplot(3, 2, 3);
stem(k, abs(X_dft), 'r', 'filled', 'LineWidth', 1.5);
title('2. DFT Magnitude Spectrum');
xlabel('k');
ylabel('|X(k)|');
xticks(k);
grid on;

% 3. DTFT Magnitude Spectrum
subplot(3, 2, 4);
plot(w, abs(X_dtft), 'b', 'LineWidth', 1.5);
title('3. DTFT Magnitude Spectrum');
xlabel('\omega');
ylabel('|X(e^{j\omega})|');
xlim([0, 2*pi]);
grid on;

% 4. IDFT Signal
subplot(3, 2, 5);
stem(n, real(x_idft), 'm', 'filled', 'LineWidth', 1.5);
title('4. IDFT Signal x(n)');
xlabel('n');
ylabel('Amplitude');
xticks(n);
grid on;

% 5. IDTFT Signal
subplot(3, 2, 6);
stem(n, real(x_idtft), 'c', 'filled', 'LineWidth', 1.5);
title('5. IDTFT Signal x(n)');
xlabel('n');
ylabel('Amplitude');
xticks(n);
grid on;