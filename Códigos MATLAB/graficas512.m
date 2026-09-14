clear;
clc;
close all;

%% 1. Grafica en el Dominio del Tiempo

data_t = readtable('adc_samples_250p0Hz_hann.csv');

figure('Color','w');

subplot(2,1,1);

plot(data_t.time_s * 1000, ...
    data_t.voltage_V, ...
    'm.-', ...
    'LineWidth', 1);

grid on;

xlabel('Tiempo [ms]');
ylabel('Voltaje [V]');

title('Señal adquirida en el dominio del tiempo - N = 512');

xlim([0 20]);

%% 2. Grafica del Espectro en Frecuencia

data_f = readtable('adc_fft_250p0Hz_hann.csv');

subplot(2,1,2);

plot(data_f.frequency_Hz, ...
    data_f.magnitude_dBFS, ...
    'm.-',...
    'LineWidth', 1);

grid on;

xlabel('Frecuencia [Hz]');
ylabel('Magnitud [dBFS]');

title('Espectro en Frecuencia (FFT) - N = 512');

xlim([0 1000]);
ylim([-120 5]);