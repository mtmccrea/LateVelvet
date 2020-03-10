
clc;
close all;
fs = 44100;
[X,Fs] = audioread('pori.wav'); %  Load an audio sample as an input signal
%[X,Fs] = audioread('VM_R1_s1.wav'); %  Load an audio sample as an input signal
%[X,Fs] = audioread('CP_R5_s1.wav'); %  Load an audio sample as an input signal
% 1. Segment 
T_seg_start = [0.1 0.125 0.15 0.175 0.2] ;% in seconds
T_seg_length = 0.025 * ones(5,1) ;% in second 
T_seg_end = T_seg_start + T_seg_length;% in seconds

N_seg_start = T_seg_start * fs;
N_seg_end = T_seg_end * fs;
X = X(N_seg_start(1):N_seg_end(1));
N = 10;
A = lpc(X,N);
b = zeros(1,N);
b(1)= 1;
a = A(1,1:N);
[H,W] = freqz(b,a);
H = H ./ H(1);

N_segments = 25;
fc = linspace(16000,8000, N_segments);
fb = linspace(5000,4000, N_segments);
G = linspace(-6,-4, N_segments);

figure(1);
subplot(3,1,1)
semilogx(W*fs/(2*pi), mag2db(abs(H))-10);
ylabel('Magnitude');%xlabel('Frequency');
set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000]')    % Frequency points
set(gca,'YTick',[-100 -50 0  ]') % dB scale
axis([45 22500 -100 10])  %Scaling of axes
hold off


subplot(3,1,2)

for n = 1 : N_segments 
[atot, btot] = testdifffilt(fb(n), fc(n), G(n), fs);
[H1,W1] = freqz(btot,atot);
semilogx(W1*fs/(2*pi), mag2db(abs(H1)));
H1 = H1 ./ H1(1);
hold on 

end
ylabel('Magnitude');%xlabel('Frequency');
set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000 ]')    % Frequency points
set(gca,'YTick',[-10 -5 0  ]') % dB scale
axis([45 22500 -8 1])  %Scaling of axes


subplot(3,1,3)
semilogx(W*fs/(2*pi), mag2db(abs(H))-10);
ylabel('Magnitude');xlabel('Frequency');
set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000]')    % Frequency points
%set(gca,'YTick',[-10 -5 0  ]') % dB scale
set(gca,'YTick',[-100 -50 0  ]') % dB scale
%axis([20 20000 -10 1])  %Scaling of axes
axis([45 22500 -100 10])  %Scaling of axes
hold on

for n = 1 : N_segments 
    offset= 10 + n * 2;
    [atot, btot] = testdifffilt(fb(n), fc(n), G(n), fs);
    [H1,W1] = freqz(btot,atot);
    H1 = H1 ./ H1(1);
    %semilogx(W1*fs/(2*pi), mag2db(abs(H1)));
    %plot(W1*fs/(2*pi), mag2db(abs(H1)));
    
    hold on
    b1 = conv(b,btot);
    a1 = conv(a,atot);
    [H1,W1] = freqz(b1,a1);
    H1 = H1 ./ H1(1);
    semilogx(W1*fs/(2*pi), mag2db(abs(H1))-offset);
    hold on
    b = b1;
    a = a1;

end


ylabel('Magnitude');xlabel('Frequency')

hold off

