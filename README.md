# Análisis de parámetros de un conversor ADC

## Descripción

En este laboratorio se realizó la **caracterización experimental de un conversor analógico-digital (ADC) de 12 bits** implementado en una **Raspberry Pi Pico 2 W**.

Se utilizó una señal senoidal de aproximadamente **250 Hz** y una frecuencia de muestreo objetivo de **2000 Hz** para verificar el comportamiento del proceso de muestreo. Posteriormente, se analizaron diferentes cantidades de muestras y puntos de FFT para estudiar la resolución espectral y el comportamiento del piso de ruido.

Los datos obtenidos fueron almacenados en archivos CSV y procesados mediante **MATLAB**, permitiendo visualizar las señales en el dominio del tiempo y sus respectivos espectros en frecuencia. Finalmente, se analizaron parámetros de desempeño del ADC y se compararon los resultados experimentales con los valores teóricos de un ADC ideal de 12 bits.

## Objetivos

### Objetivo general

Caracterizar experimentalmente el funcionamiento de un ADC de 12 bits mediante la adquisición y análisis de una señal senoidal, evaluando su frecuencia de muestreo, comportamiento espectral y principales parámetros de desempeño.

### Objetivos específicos

* Determinar experimentalmente la frecuencia de muestreo del ADC y verificar su estabilidad mediante el osciloscopio.
* Analizar la señal adquirida en los dominios del tiempo y la frecuencia utilizando la FFT.
* Evaluar el efecto del número de muestras sobre la resolución espectral y el piso de ruido.
* Determinar parámetros como **SNR, THD, SINAD, ENOB, SFDR y jitter temporal**.
* Comparar los resultados experimentales con los valores teóricos correspondientes a un ADC ideal de 12 bits.

## Hardware utilizado

* Raspberry Pi Pico 2 W
* Generador de señales
* Osciloscopio
* Computador
* Cables y conexión tipo T

## Software utilizado

* MicroPython
* Thonny
* MATLAB

## Configuración experimental

Para la primera fase se configuró el generador de señales con:

* **Señal:** senoidal
* **Frecuencia:** 250 Hz
* **Voltaje pico a pico:** 2 V
* **Offset:** 1,65 V
* **Frecuencia de muestreo objetivo:** 2000 Hz

La señal fue conectada mediante una conexión tipo T al osciloscopio y a la entrada **GP27 de la Raspberry Pi Pico 2 W**. El pin **GP15** se utilizó como marcador de muestreo y se estableció una tierra común entre los equipos.

## Fase 1 — Verificación de la frecuencia de muestreo

Se utilizó el programa `ADC_testing.py` para realizar la adquisición de la señal.

La frecuencia de muestreo medida mediante el osciloscopio fue aproximadamente **2000 Hz**, mientras que el software reportó **2000,415 Hz**, muy cercano al valor objetivo de 2000 Hz.

Para una señal de entrada de 250 Hz:

**Muestras por ciclo = 2000 Hz / 250 Hz = 8 muestras/ciclo**

Por lo tanto, se verificó experimentalmente que el sistema adquiere aproximadamente **8 muestras por período**.

### Resultados de muestreo

| Parámetro                          |   Resultado |
| ---------------------------------- | ----------: |
| Frecuencia de muestreo objetivo    |     2000 Hz |
| Frecuencia reportada por software  | 2000,415 Hz |
| Frecuencia medida con osciloscopio |     2000 Hz |
| Timing jitter                      |    2,557 µs |
| Frecuencia de entrada              |      250 Hz |
| Muestras por ciclo                 |           8 |

## Fase 2 — Procesamiento espectral y FFT

Se realizaron cuatro pruebas variando el número de muestras y la longitud de la FFT:

| Prueba |    N | M = NFFT |
| ------ | ---: | -------: |
| A      |  128 |      128 |
| B      |  256 |      256 |
| C      |  512 |      512 |
| D      | 1024 |     1024 |

No fue posible realizar las pruebas con **2048 y 4096 muestras** debido a un error de saturación de memoria durante la ejecución del programa.

Para cada prueba se generaron archivos CSV correspondientes a:

* Muestras adquiridas.
* Datos de la FFT.
* Resumen de resultados.

Estos archivos fueron utilizados posteriormente para realizar el análisis en MATLAB.

## Resultados de la FFT

|    M | Resolución Δf | Ganancia FFT |     Piso teórico |     Piso medido |
| ---: | ------------: | -----------: | ---------------: | --------------: |
|  128 |     15,625 Hz |     18,06 dB |  -92,10 dBFS/bin | -58,73 dBFS/bin |
|  256 |     7,8125 Hz |     21,07 dB |  -95,11 dBFS/bin | -59,58 dBFS/bin |
|  512 |    3,90625 Hz |     24,08 dB |  -98,08 dBFS/bin | -62,66 dBFS/bin |
| 1024 |   1,953125 Hz |     27,09 dB | -101,13 dBFS/bin | -67,25 dBFS/bin |

Al aumentar el número de muestras, la **resolución espectral mejora** y el **piso de ruido medido disminuye**. El piso de ruido pasó de -58,73 dBFS/bin con 128 muestras a -67,25 dBFS/bin con 1024 muestras.

## Análisis de los parámetros dinámicos

Los principales parámetros obtenidos experimentalmente fueron:

| Parámetro                |  M=128 |  M=256 |  M=512 | M=1024 |
| ------------------------ | -----: | -----: | -----: | -----: |
| SNR [dB]                 |  48,89 |  38,88 |  37,92 |  38,45 |
| THD [%]                  |  0,673 |  0,681 |  0,402 |  0,360 |
| SINAD [dB]               |  42,36 |  37,55 |  37,50 |  38,08 |
| ENOB [bits]              |   6,74 |   5,95 |   5,94 |   6,03 |
| SFDR [dBc]               |  49,66 |  46,26 |  50,70 |  54,79 |
| Piso de ruido [dBFS/bin] | -58,73 | -59,58 | -62,66 | -67,25 |
| Jitter [µs]              |  4,607 |  3,341 |  2,479 |  2,051 |

Los resultados muestran que el ADC real presenta diferencias respecto al comportamiento ideal de un ADC de 12 bits. Estas diferencias se relacionan principalmente con la presencia de ruido, distorsión y variaciones durante el proceso de adquisición.

El mejor resultado de THD se obtuvo con **M = 1024**, con un valor de **0,36 %**, mientras que el mejor SFDR fue de **54,79 dBc**. El ENOB obtenido fue inferior a los 12 bits nominales, mostrando que la resolución efectiva del sistema es menor debido a los efectos de ruido y distorsión.

## Gráficas en MATLAB

Los archivos CSV generados por la Raspberry Pi Pico 2 W fueron utilizados en MATLAB para representar:

* Señal adquirida en el dominio del tiempo.
* Espectro de frecuencia mediante FFT.
* Comparación de los espectros para diferentes valores de M.
* Comportamiento del piso de ruido.

Las gráficas permitieron observar la componente fundamental alrededor de **250 Hz** y comprobar visualmente que al aumentar el número de muestras mejora la resolución espectral y disminuye el piso de ruido por bin.

## Conclusiones

* Se verificó experimentalmente que la frecuencia de muestreo del sistema se mantuvo cercana a los **2000 Hz** establecidos.
* Para una señal de 250 Hz se obtuvieron aproximadamente **8 muestras por período**.
* El aumento del número de puntos de la FFT permitió mejorar la resolución espectral.
* El piso de ruido medido disminuyó al aumentar el número de muestras, pasando de **-58,73 dBFS/bin** a **-67,25 dBFS/bin**.
* Los parámetros SNR, THD, SINAD, ENOB, SFDR y jitter permitieron evaluar el comportamiento real del ADC.
* Los resultados experimentales fueron diferentes a los valores ideales de un ADC de 12 bits, evidenciando la influencia del ruido, la distorsión y otros factores propios del sistema real.
* La práctica permitió relacionar los conceptos de **muestreo, FFT, resolución espectral, ganancia de procesamiento y ruido** con una medición experimental.


## Autores

**Paula Quintero**
**Ediem Valero**

Universidad Militar Nueva Granada
Ingeniería de Telecomunicaciones
Comunicación Digital
Bogotá, Colombia — 2026
