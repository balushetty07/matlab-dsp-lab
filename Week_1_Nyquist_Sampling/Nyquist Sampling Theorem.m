clc; clear; close all;

fm = 100;                          % Signal frequency (Hz)
t  = 0:0.0001:0.05;                % Continuous time
x  = cos(2*pi*fm*t);               % Original signal

fs_list = [2*fm, 1.5*fm, 4*fm];    % Nyquist, below, above
titles  = {'a) Fs = 2Fm (Nyquist Rate)', ...
           'b) Fs = 1.5Fm (Aliasing)', ...
           'c) Fs = 4Fm (Above Nyquist)'};

figure('Color','w','Position',[100 100 1000 800]);

for k = 1:3
    fs = fs_list(k);
    Ts = 1/fs;
    ts = 0:Ts:0.05;
    xs = cos(2*pi*fm*ts);

    % ---- Sinc reconstruction ----
    xr = zeros(size(t));
    for n = 1:length(ts)
        xr = xr + xs(n)*sinc((t - ts(n))/Ts);
    end

    % ---- Time domain ----
    subplot(3,2,2*k-1);
    plot(t, x, 'r', 'LineWidth', 1.2); hold on;
    stem(ts, xs, 'filled', 'MarkerSize', 4);
    plot(t, xr, 'b--', 'LineWidth', 1.2);
    title(['Time: ' titles{k}]);
    xlabel('Time (s)'); ylabel('Amplitude');
    xlim([0 0.05]); grid on;
    legend({'Original x(t)','Samples x[n]','Reconstructed x_r(t)'}, ...
           'Location','best','FontSize',8);

    % ---- Spectrum ----
    N = length(xs);
    X = abs(fftshift(fft(xs))) / N;
    f_axis = (-N/2:N/2-1)*(fs/N);

    subplot(3,2,2*k);
    plot(f_axis, X, 'm-', 'LineWidth', 1.5); hold on;
    plot(f_axis, X, 'ko', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
    title(['Spectrum (wave): ' titles{k}]);
    xlabel('Frequency (Hz)'); ylabel('|X(f)|');
    xlim([-fs/2*1.1, fs/2*1.1]);
    ylim([0, max(X)*1.2 + eps]);
    grid on;
    legend({'|X(f)| wave'},'Location','best','FontSize',8);
end

sgtitle('Illustration of Nyquist Sampling Theorem');