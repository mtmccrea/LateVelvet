clc;
close all;


fs = 44100;
[X,Fs] = audioread('pori.wav'); %  Load an audio sample as an input signal
T_seg_start = [0.1 0.125 0.15 0.175 0.2] ;% in seconds
T_seg_length = 0.025 * ones(5,1) ;% in second 
T_seg_end = T_seg_start + T_seg_length;% in seconds

N_seg_start = T_seg_start * fs;
N_seg_end = T_seg_end * fs;
X = X(N_seg_start(1):N_seg_end(1));
N_lpc = 10;
A = lpc(X,N_lpc);
b = zeros(1,N_lpc);
b(1)= 1;
a = A(1,1:N_lpc);
[H,W] = freqz(b,a);
H = H ./ H(1);

N_segments  = 25; % number of segments 

fc_range = [8000,16000] ;
fb_range = [4000, 5000] ;
G_range = [-4,-6];

[Adiff, Bdiff, Acolor, Bcolor] = GenDiffFilters(a,b,N_segments,fc_range,fb_range,G_range, fs);