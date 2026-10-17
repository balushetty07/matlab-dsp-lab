clc;
clear;
close all;

x = [1 0 -1 0];
y = [7 8 3 4];

N = length(x);
n = 0:N-1;
k = 0:N-1;

% Manual DFT:  X(k) = sum_n x(n) * exp(-j*2*pi*k*n/N)
% Built as an N x N DFT matrix and applied by matrix multiplication

W    = exp(-1i*2*pi/N);      % twiddle factor base
nk   = (n.')*k;              % N x N exponent matrix  (n' * k)
DFT  = W.^nk;                % N x N DFT matrix

dft = @(s) s*DFT;            % dft of a row vector (no fft() used)

X = dft(x);
Y = dft(y);

% Manual modulo  (works for negative numbers too)

mymod = @(a,b) a - b.*floor(a./b);

% Manual circular shift, equivalent to circshift(v, s) for a row vector
%   y(i) = v((i - s) mod N)

cshift = @(v,s) v(mymod(n - s, N) + 1);

% Linearity

a = 2;
b = 3;

LHS = dft(a*x + b*y);
RHS = a*X + b*Y;

disp("Linearity property");
disp("LHS=DFT{ax(n)+by(n)}");
disp(LHS);
disp("RHS=aX(k)+bY(k)");
disp(RHS);

% Periodicity

E1 = exp(-1i*2*pi*(n.')*k/N);
E2 = exp(-1i*2*pi*(n.')*(k+N)/N);

LHS = x*E1;
RHS = x*E2;

disp("Periodicity property");
disp("LHS=X(k)");
disp(LHS);
disp("RHS=X(k+N)");
disp(RHS);

% Circular shift

m = 2;

LHS = dft(cshift(x,m));
RHS = X.*exp(-1i*2*pi*k*m/N);

disp("Circular Shift");
disp("LHS=DFT{x((n-m))}");
disp(LHS);
disp("RHS=X(k)*exp(-j2pikm/N)");
disp(RHS);

% Conjugate symmetry

idx = mymod(-n,N) + 1;

LHS = X;
RHS = conj(X(idx));          % conj() is element-wise; replace with
                             % real(X)-1i*imag(X) if truly forbidden

disp("Conjugate symmetry");
disp("LHS=X(k)");
disp(LHS);
disp("RHS=X*(N-n)");
disp(RHS);

% Circular symmetry of a sequence

x_rev = x(mymod(-n,N) + 1);      % x[(-n)_N]
x_e   = 0.5*(x + x_rev);         % even part (unused in LHS/RHS below,
x_o   = 0.5*(x - x_rev);         % odd part   kept for completeness)

LHS = dft(x_rev);
RHS = X(mymod(-k,N) + 1);

disp("Circular symmetry");
disp("x[(-n)_N] = ");
disp(x_rev);
disp("LHS=DFT{x[(-n)_N]}");
disp(LHS);
disp("RHS=X[(-k)_N]");
disp(RHS);

figure('Name','Linearity & Periodicity','Color','w');

% Row 1 : Linearity
subplot(2,2,1);
stem(k, real(dft(a*x + b*y)), "filled");
title("Linearity - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(2,2,2);
stem(k, real(a*X + b*Y), "filled");
title("Linearity - RHS");
xlabel('k'); ylabel("Real part"); grid on;

% Row 2 : Periodicity
subplot(2,2,3);
stem(k, real(x*E1), "filled");
title("Periodicity - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(2,2,4);
stem(k, real(x*E2), "filled");
title("Periodicity - RHS");
xlabel('k'); ylabel("Real part"); grid on;

figure('Name','Circular Properties','Color','w');

% Row 1 : Circular Shift
subplot(3,2,1);
stem(k, real(dft(cshift(x,m))), "filled");
title("Circular Shift - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(3,2,2);
stem(k, real(X.*exp(-1i*2*pi*k*m/N)), "filled");
title("Circular Shift - RHS");
xlabel('k'); ylabel("Real part"); grid on;

% Row 2 : Conjugate Symmetry
subplot(3,2,3);
stem(k, real(X), "filled");
title("Conjugate symmetry - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(3,2,4);
stem(k, real(conj(X(idx))), "filled");
title("Conjugate symmetry - RHS");
xlabel('k'); ylabel("Real part"); grid on;

% Row 3 : Circular Symmetry
subplot(3,2,5);
stem(k, real(dft(x_rev)), "filled");
title("Circular symmetry - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(3,2,6);
stem(k, real(X(mymod(-k,N) + 1)), "filled");
title("Circular symmetry - RHS");
xlabel('k'); ylabel("Real part"); grid on;