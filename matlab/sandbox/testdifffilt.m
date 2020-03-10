% In this filterdesign I implement and investigate the behaviour of a second order notch
% filter. 
% The original filter function is H(z) = 1 + (V0 - 1)[1 - A2(z)]/2
% with A2(z) = [-c + d(1 -c)z^{-1} + z^{-2}]/[1 + d(1 -c)z^{-1} - c*z^{-2}]
% with c and d as stated in the code below and 0 < V0 < 1 as 
% desribed in the book DAFX: Digital Audio Effects
% Second Edition Edited by Udo Zölzer
% For this code I had to restructure the transfer function to calclulate 
% the final filter coefficients. 
% Furthermore, I analysed the filter using freqz.m, impz.m, zplane.m, phasez.m
% phasedelay.m and grpdelay.m as given in the lecture.


function [atot, btot] = testdifffilt(fb, fc, G, fs) 
lengthfb = length(fb);
V0 = 10^(G/20); % magnitude gain
%V0 = db2mag(G);

%the original filter design consists of the 
for i = 1 : lengthfb
    
c = (tan(pi*fb(i)/fs)-V0)/(tan(pi*fb(i)/fs)+V0);

d = -cos(2*pi*fc(i)/fs);

% filter coefficient with the structure of an all pole filter 

b = [-c  d*(1-c) 1];
a = [1 d*(1-c) -c];

% calculating the filter coefficients for the notch filter 

V = V0 - 1 ;
btot = (2 + V) * a - V * b ;
atot = 2 * a ;

%[H, w] = freqz(btot,atot, 512);
%figure(2);
%%figure(2);
%plot(w*fs/(2*pi), mag2db(abs(H)));
%hold on
%figure(3);
%impz(btot,atot);
%legend fc=3000kHz fc=4000kHz fc=5000kHz
%hold on
%figure(4);
%zplane(btot,atot);
%figure(5);
%phasez(btot,atot)
%legend fc=3000kHz fc=4000kHz fc=5000kHz
%title ('Phase Response')
%hold on
%figure(6);
%phasedelay(btot,atot);
%legend fc=3000kHz fc=4000kHz fc=5000kHz
%title ('Phase delay')
%hold on
%figure(7);
%grpdelay(btot,atot);
%legend fc=3000kHz fc=4000kHz fc=5000kHz
%title ('Group delay')
%hold on

end
end

