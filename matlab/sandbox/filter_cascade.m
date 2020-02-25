clc;
close all;

addpath('/Users/dyne/Documents/Courses/ELEC-E5620 Audio Signal Processing/Demo_FVN/sound_examples/OriginalRIR');

[X,Fs] = audioread('pori.wav'); %  Load an audio sample as an input signal
%[X,Fs] = audioread('VM_R1_s1.wav'); %  Load an audio sample as an input signal
%[X,Fs] = audioread('CP_R5_s1.wav'); %  Load an audio sample as an input signal

%%
N = 10;
A = lpc(X(2590:0.013*fs),N);
b = zeros(1,N);
b(1)= 1;
a = A(1,1:N);
[H,W] = freqz(b,a);
H = H ./ H(1);
semilogx(W*fs/(2*pi), mag2db(abs(H)));
ylabel('Magnitude');xlabel('Frequency')
set(gca,'XTick',[30 100 300 1000 3000 10000 16000]')    % Frequency points
set(gca,'YTick',[-100 -50 0  ]') % dB scale
axis([20 20000 -100 10])  % Scaling of axes