%%
%--------------------------------------------------------------------------
% Matlab code investigating the effects of quatization on the frequency 
% spectrum of signals
%--------------------------------------------------------------------------
close all
%% SIGNAL DEFINITION
%all sinusoids have magnitude 1

%sampling rate
fs = 200000;
%sampling preiod
T = 1/fs;
%run time
t = (1:T:1.005)-1;

%signal frequencies
LF_hz = 1000;
IF_hz = 10000;
HF_hz = 20000;

%signal generation
LF = cos(2*pi*LF_hz.*t);
IF = cos(2*pi*IF_hz.*t);
HF = cos(2*pi*HF_hz.*t);

%% PLOTTING TIME
%plotting generated functions
%convertin time to milli seconds
t_ms = t*1000;

figure

subplot(3,3,1)
plot(t_ms,LF)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 1KHz SINUSOID")

subplot(3,3,2)
plot(t_ms,IF)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 10KHz SINUSOID")

subplot(3,3,3)
plot(t_ms,HF)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 20KHz SINUSOID")

%% FFT OF UN-ADC'ED SIGNAL

%zero padding to increase f_res
pad_factor = 5;

%padding to increase frequency resolution
LF_p = [LF zeros(1,length(LF)*pad_factor)];
IF_p = [IF zeros(1,length(IF)*pad_factor)];
HF_p = [HF zeros(1,length(HF)*pad_factor)];

%taking fourier transform
LF_W = fftshift(fft(LF_p))*pad_factor./length(LF_p);
IF_W = fftshift(fft(IF_p))*pad_factor./length(LF_p);
HF_W = fftshift(fft(HF_p))*pad_factor./length(LF_p);

%normalising
LF_W = LF_W./max(LF_W);
IF_W = IF_W./max(IF_W);
HF_W = HF_W./max(HF_W);
%frequency axis
f_res = 1/(length(LF_W)*T);
f = 0:f_res:(length(LF_W)-1)*f_res;
%shifting to center arround zero
f = f - f((length(f))/2);
%rescaling to KHz
f_khz = f/1000;

%% PLOTTING FREQUENCY

subplot(3,3,4)
plot(f_khz,abs(LF_W))
xlabel("Frequency(Khz)")
ylabel("Amplitude(V)")
title("FFT OF 1KHz SINUSOID")

subplot(3,3,5)
plot(f_khz,abs(IF_W))
xlabel("Frequency(Khz)")
ylabel("Amplitude(V)")
title("FFT OF 10KHz SINUSOID")

subplot(3,3,6)
plot(f_khz,abs(HF_W))
xlabel("Frequency(Khz)")
ylabel("Amplitude(V)")
title("FFT OF 20KHz SINUSOID")

subplot(3,3,7)
plot(f_khz,20*log10(abs(LF_W)))
xlabel("Frequency(Khz)")
ylabel("Amplitude(dBv)")
title("FFT OF 1KHz SINUSOID")

subplot(3,3,8)
plot(f_khz,20*log10(abs(IF_W)))
xlabel("Frequency(Khz)")
ylabel("Amplitude(dBv)")
title("FFT OF 10KHz SINUSOID")

subplot(3,3,9)
plot(f_khz,20*log10(abs(HF_W)))
xlabel("Frequency(Khz)")
ylabel("Amplitude(dBv)")
title("FFT OF 20KHz SINUSOID")

%% Question 1.1 - 1.2

%
% Plot  the  normalised  magnitude  spectra  and  determine  the  spurious  
% levels  from  the  output  of  a  DRFM  that receives the following 
% signals with differently specified A/D converters.
%

%used to increase frequency resolution of fft
pad_factor = 5;

%----------------------------------------------
%One signal using a *1* bit A/D converter: 5KHz
%----------------------------------------------
bits = 1;
amplitude = 1;
IF_1b = IF;

%time domain
IF_1b= adc_sample(bits,amplitude,IF_1b);
%frequency domain
IF_1b_p = [IF_1b zeros(1,length(IF_1b)*pad_factor)];
%./ to remove fft gain
IF_1b_w = fftshift(fft(IF_1b_p))*pad_factor./length(IF_1b_p);
%Normalising
IF_1b_w = IF_1b_w./max(IF_1b_w);

%----------------------------------------------
%One signal using a *5* bit A/D converter: 5KHz
%----------------------------------------------
bits = 5;
amplitude = 1;
IF_5b = IF;

%time domain
IF_5b = adc_sample(bits,amplitude,IF_5b);
%frequency domain
IF_5b_p = [IF_5b zeros(1,length(IF_5b)*pad_factor)];
%./ to remove fft gain
IF_5b_w = fftshift(fft(IF_5b_p))*pad_factor./length(IF_5b_p);
%normalsising
IF_5b_w = IF_5b_w./max(IF_5b_w);
%----------------------------------------------
%plotting
%----------------------------------------------

%frequency axis
f_res = 1/(length(IF_1b_w)*T);
f = 0:f_res:(length(IF_1b_w)-1)*f_res;
%shifting to center arround zero
f = f - f((length(f))/2);
%rescaling to KHz
f_khz = f/1000;

figure
subplot(3,2,1)
plot(t,IF_1b)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 10KHz SINUSOID - 1 BIT ADC")

subplot(3,2,2)
plot(t,IF_5b)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 10KHz SINUSOID - 5 BIT ADC")

subplot(3,2,3)
plot(f_khz,abs(IF_1b_w))
xlabel("Frequency(KHz)")
ylabel("Amplitude(V)")
title("FFT OF 10KHz SINUSOID - 1 BIT ADC")

subplot(3,2,4)
plot(f_khz,abs(IF_5b_w))
xlabel("Frequency(KHz)")
ylabel("Amplitude(V)")
title("FFT OF 10KHz SINUSOID - 5 BIT ADC")

subplot(3,2,5)
plot(f_khz,20*log10(abs(IF_1b_w)))
xlabel("Frequency(KHz)")
ylabel("Amplitude(dBv)")
title("FFT OF 10KHz SINUSOID - 1 BIT ADC")

subplot(3,2,6)
plot(f_khz,20*log10(abs(IF_5b_w)))
xlabel("Frequency(KHz)")
ylabel("Amplitude(dBv)")
title("FFT OF 10KHz SINUSOID - 5 BIT ADC")

%% Question 1.3 - 1.4


pad_factor = 5;
sig_3 = LF + IF + HF;


%adc'ing signal
bits = 1;
amplitude = 1;
sig_3_1b = adc_sample(bits, amplitude, sig_3);
%normalsing
sig_3_1b = sig_3_1b./max(sig_3_1b);

bits = 5;
amplitude = 1;
sig_3_5b = adc_sample(bits, amplitude, sig_3);
%normalsing
sig_3_5b = sig_3_5b./max(sig_3_5b);

%frequency domain

%frequency domain
sig_3_1b_p = [sig_3_1b zeros(1,length(sig_3_1b)*pad_factor)];
%./ to remove fft gain
sig_3_1b_w = fftshift(fft(sig_3_1b_p))*pad_factor./length(sig_3_1b_p);
%normalising
sig_3_1b_w = sig_3_1b_w./max(sig_3_1b_w);

sig_3_5b_p = [sig_3_5b zeros(1,length(sig_3_1b)*pad_factor)];
%./ to remove fft gain
sig_3_5b_w = fftshift(fft(sig_3_5b_p))*pad_factor./length(sig_3_5b_p);
%normalising
sig_3_5b_w = sig_3_5b_w./max(sig_3_5b_w);

%frequency axis
f_res = 1/(length(sig_3_1b_w)*T);
f = 0:f_res:(length(sig_3_1b_w)-1)*f_res;
%shifting to center arround zero
f = f - f((length(f))/2);
%rescaling to KHz
f_khz = f/1000;



%plotting

figure

subplot(3,2,1)
plot((1:1:length(sig_3_1b))*T, sig_3_1b)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN COMBINED SINUSOIDS - 1 BIT ADC")

subplot(3,2,2)
plot((1:1:length(sig_3_5b))*T, sig_3_5b)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN COMBINED SINUSOIDS - 5 BIT ADC")

subplot(3,2,3)
plot(f_khz,abs(sig_3_1b_w))
xlabel("Frequency(KHz)")
ylabel("Amplitude(V)")
title("FFT OF COMBINED SINUSOIDS - 1 BIT ADC")

subplot(3,2,4)
plot(f_khz,abs(sig_3_5b_w))
xlabel("Frequency(KHz)")
ylabel("Amplitude(V)")
title("FFT OF COMBINED SINUSOIDS - 5 BIT ADC")


subplot(3,2,5)
plot(f_khz,20*log10(abs(sig_3_1b_w)))
xlabel("Frequency(KHz)")
ylabel("Amplitude(dBv)")
title("FFT OF COMBINED SINUSOIDS - 1 BIT ADC")

subplot(3,2,6)
plot(f_khz,20*log10(abs(sig_3_5b_w)))
xlabel("Frequency(KHz)")
ylabel("Amplitude(dBv)")
title("FFT OF COMBINED SINUSOIDS - 5 BIT ADC")




















