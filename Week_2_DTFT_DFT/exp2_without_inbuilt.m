% 5-Panel DSP Analysis Without Built-in Transform Functions
clc; clear; close all;

% --- Computations ---
x = [1 2 3 4];
N = length(x);
n = 0:N-1;
k = 0:N-1;

%--- 1. DFT Without Built-in Function ---
X_dft = zeros(1, N);

for k1 = 0:N-1
    for n1 = 0:N-1
        X_dft(k1+1) = X_dft(k1+1) + ...
            x(n1+1) * exp(-1i * 2*pi*n1*k1/N);
    end
end

% --- 2. DTFT Without Built-in Function ---
% Frequency range
M = 1024;
dw = 2*pi/M;
w = 0:dw:(2*pi-dw);

X_dtft = zeros(1, M);

for m = 1:M
    for n1 = 0:N-1
        X_dtft(m) = X_dtft(m) + ...
            x(n1+1) * exp(-1i * w(m) * n1);
    end
end

% --- 3. IDFT Without Built-in Function ---
x_idft = zeros(1, N);

for n1 = 0:N-1
    for k1 = 0:N-1
        x_idft(n1+1) = x_idft(n1+1) + ...
            (1/N) * X_dft(k1+1) * exp(1i * 2*pi*k1*n1/N);
    end
end

% --- 4. IDTFT Without Built-in Function ---
x_idtft = zeros(1, N);

for n1 = 0:N-1
    for m = 1:M
        x_idtft(n1+1) = x_idtft(n1+1) + ...
            X_dtft(m) * exp(1i * w(m) * n1) * dw / (2*pi);
    end
end

% --- Display Results ---
disp('DFT is:');
disp(X_dft.');

disp('DFT Magnitude is:');
disp(abs(X_dft).');

disp('IDFT is:');
disp(real(x_idft).');

disp('IDTFT is:');
disp(real(x_idtft).');

% --- Plotting ---
figure('Name', 'Signal Analysis Without Built-in Functions', ...
       'Position', [100, 100, 900, 800]);

% 1. Original Signal
subplot(3, 2, [1, 2]);
stem(n, x,'filled', 'LineWidth', 1.5);
title('1. Original Signal x(n)');
xlabel('n');
ylabel('Amplitude');
xticks(n);
grid on;

% 2. DFT Magnitude Spectrum
subplot(3, 2, 3);
stem(k, abs(X_dft),'filled', 'LineWidth', 1.5);
title('2. DFT Signal');
xlabel('k');
ylabel('|X(k)|');
xticks(k);
grid on;

% 3. DTFT Magnitude Spectrum
subplot(3, 2, 4);
plot(w, abs(X_dtft),'LineWidth', 1.5);
title('3. DTFT Signal');
xlabel('\omega');
ylabel('|X(e^{j\omega})|');
xlim([0, 2*pi]);
grid on;

% 4. IDFT Signal
subplot(3, 2, 5);
stem(n, real(x_idft),'filled', 'LineWidth', 1.5);
title('4. IDFT Signal x(n)');
xlabel('n');
ylabel('Amplitude');
xticks(n);
grid on;

% 5. IDTFT Signal
subplot(3, 2, 6);
stem(n, real(x_idtft),'filled', 'LineWidth', 1.5);
title('5. IDTFT Signal x(n)');
xlabel('n');
ylabel('Amplitude');
xticks(n);
grid on;

