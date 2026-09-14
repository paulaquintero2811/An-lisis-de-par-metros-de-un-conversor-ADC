clear;
clc;
close all;

% ==========================================================
% COMPARACION DE ESPECTROS FFT
% N = M = 128, 256, 512 y 1024
% ==========================================================

% Leer los archivos CSV
fft128  = readtable('adc_fft_128.csv');
fft256  = readtable('adc_fft_256.csv');
fft512  = readtable('adc_fft_512.csv');
fft1024 = readtable('adc_fft_1024.csv');

% Extraer frecuencia y magnitud en dBFS
f128  = fft128.frequency_Hz;
dB128 = fft128.magnitude_dBFS;

f256  = fft256.frequency_Hz;
dB256 = fft256.magnitude_dBFS;

f512  = fft512.frequency_Hz;
dB512 = fft512.magnitude_dBFS;

f1024  = fft1024.frequency_Hz;
dB1024 = fft1024.magnitude_dBFS;


% ==========================================================
% GRAFICA 1: ESPECTRO COMPLETO
% ==========================================================

figure;

plot(f128, dB128, 'm-', 'LineWidth', 1);
hold on;

plot(f256, dB256, 'r-', 'LineWidth', 1);
plot(f512, dB512, 'b-', 'LineWidth', 1);
plot(f1024, dB1024, 'k-', 'LineWidth', 1);

grid on;

xlabel('Frecuencia [Hz]');
ylabel('Magnitud [dBFS]');

title('Comparación de espectros FFT para diferentes valores de M');

xlim([0 1000]);
ylim([-120 5]);

legend('N=M=128', ...
    'N=M=256', ...
    'N=M=512', ...
    'N=M=1024', ...
    'Location', 'best');

hold off;


% ==========================================================
% GRAFICA 2: AMPLIACION DEL PISO DE RUIDO
% ==========================================================

figure;

plot(f128, dB128, 'm-', 'LineWidth', 1);
hold on;

plot(f256, dB256, 'r-', 'LineWidth', 1);
plot(f512, dB512, 'b-', 'LineWidth', 1);
plot(f1024, dB1024, 'k-', 'LineWidth', 1);

grid on;

xlabel('Frecuencia [Hz]');
ylabel('Magnitud [dBFS]');

title('Comparación del piso de ruido para diferentes valores de M');

xlim([0 1000]);
ylim([-85 -45]);

legend('N=M=128', ...
    'N=M=256', ...
    'N=M=512', ...
    'N=M=1024', ...
    'Location', 'best');

hold off;
