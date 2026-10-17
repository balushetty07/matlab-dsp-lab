clc;
clear;
close all;

x=[1 0 -1 0];
% x=[1 2 3 4];
y=[7 8 3 4];

N=length(x);
n=0:N-1;
X=fft(x);
Y=fft(y);
 
%Linearity
a=2;
b=3;

LHS=fft(a*x+b*y);
RHS=a*X+b*Y;

disp("Linearity property");
disp("LHS=DFT{ax(n)+by(n)}");
disp(LHS);
disp("RHS=aX(k)+bY(k)");
disp(RHS);

%Periodicity
k=0:N-1;

LHS = x * exp(-1i * 2 * pi * (n.') * k / N);
RHS = x * exp(-1j * 2 * pi * (n.') * (k+N) / N);

disp("Periodicity property");
disp("LHS=X(k)");
disp(LHS);
disp("RHS=X(k+N)");
disp(RHS);

%Circular shift
m=2;

LHS=fft(circshift(x,m));
RHS=X.*exp(-1j*2*pi*k*m/N);

disp("Circular Shift");
disp("LHS=DFT{x((n-m))}");
disp(LHS);
disp("RHS=X(k)*exp(-j2pikm/N)");
disp(RHS);

%Conjugate symmetry
idx=mod(-n,N)+1;

LHS=X;
RHS=conj(X(idx));

disp("Conjugate symmetry");
disp("LHS=X(k)");
disp(LHS);
disp("RHS=X*(N-n)");
disp(RHS);

%Circular symmetry of a sequence
x_rev = x(mod(-n,N)+1);       % x[(-n)_N]
x_e   = 0.5*(x + x_rev);      % even part
x_o   = 0.5*(x - x_rev);      % odd part

LHS = fft(x_rev);
RHS = X(mod(-k,N)+1);

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
stem(k, real(fft(a*x+b*y)),"filled");
title("Linearity - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(2,2,2);
stem(k, real(a*X+b*Y),"filled");
title("Linearity - RHS");
xlabel('k'); ylabel("Real part"); grid on;

% Row 2 : Periodicity
subplot(2,2,3);
stem(k, real(x * exp(-1i * 2 * pi * (n.') * k / N)),"filled");
title("Periodicity - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(2,2,4);
stem(k, real(x * exp(-1j * 2 * pi * (n.') * (k+N) / N)),"filled");
title("Periodicity - RHS");
xlabel('k'); ylabel("Real part"); grid on;

figure('Name','Circular Properties','Color','w');

% Row 1 : Circular Shift
subplot(3,2,1);
stem(k, real(fft(circshift(x,m))),"filled");
title("Circular Shift - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(3,2,2);
stem(k, real(X.*exp(-1j*2*pi*k*m/N)),"filled");
title("Circular Shift - RHS");
xlabel('k'); ylabel("Real part"); grid on;

% Row 2 : Conjugate Symmetry
subplot(3,2,3);
stem(k, real(X),"filled");
title("Conjugate symmetry - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(3,2,4);
stem(k, real(conj(X(idx))),"filled");
title("Conjugate symmetry - RHS");
xlabel('k'); ylabel("Real part"); grid on;

% Row 3 : Circular Symmetry
subplot(3,2,5);
stem(k, real(fft(x_rev)),"filled");
title("Circular symmetry - LHS");
xlabel('k'); ylabel("Real part"); grid on;

subplot(3,2,6);
stem(k, real(X(mod(-k,N)+1)),"filled");
title("Circular symmetry - RHS");
xlabel('k'); ylabel("Real part"); grid on;