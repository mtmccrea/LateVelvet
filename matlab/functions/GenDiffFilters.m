
function [Adiff, Bdiff, Acolor, Bcolor] = GenDiffFilters(H1A,H1B,N,fc_range, fb_range, G_range ,fs)

    % [Adiff, Bdiff, Acolor, Bcolor] = GenDiffFilters(H1A,H1B,N)
    % INPUT 
    % H1A : numerator  filter coefficients of the all-pole filter
    % H1B : denominator filter coefficients of the all-pole filter
    % N : number of segments
    % fc_range : vector of centerfrequency range , 1x2 
    % fb_range : vector of bandwith range , 1x2 
    % G_range : vector of gain range, 1x2
    % fs : sample frequency [Hz]
    % 
    % OUTPUT
    % Adiff : matrix of denominator filter coefficients , size(3,N-1)
    % Bdiff : matrix of numerator filter coefficients , size(3,N-1)
    % Acolor : cell of vectors of denominator all-pole filter coefficients, 1xN 
    % Bcolor : cell of vectors numerator of all-pole filter coefficients, 1xN
    %
    % This function uses the function diffFiltCoeff.m
    
    
    % create parameter ranges
    fc = linspace(fc_range(1),fc_range(2), N-1); 
    fb = linspace(fb_range(1),fb_range(2), N-1);  
    G  = linspace(G_range(1),G_range(2), N-1);

    % plot original H1 frequency response
%     [H,W] = freqz(H1B,H1A);
%     H = H ./ H(1);
% 
%     figure(1);
%     subplot(3,1,1)
%     semilogx(W*fs/(2*pi), mag2db(abs(H))-10);
%     ylabel('Magnitude');%xlabel('Frequency');
%     set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000]')    % Frequency points
%     set(gca,'YTick',[-100 -50 0  ]') % dB scale
%     axis([45 22500 -100 10])  %Scaling of axes
%     hold off
% 
%     %plot the notch filters for each segment 
%     subplot(3,1,2)
% 
%     for n = 1 : N-1 
%         [atot, btot] = diffFiltCoeff(fb(n), fc(n), G(n), fs);
%         [H1,W1] = freqz(btot,atot);
%         semilogx(W1*fs/(2*pi), mag2db(abs(H1)));
%         H1 = H1 ./ H1(1);
%         hold on 
% 
%     end
%     
%     ylabel('Magnitude');%xlabel('Frequency');
%     set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000 ]')    % Frequency points
%     set(gca,'YTick',[-10 -5 0  ]') % dB scale
%     axis([45 22500 -8 1])  %Scaling of axes
% 
%     % plot the estimated frequency response for 1. segment 
%     subplot(3,1,3)
%     semilogx(W*fs/(2*pi), mag2db(abs(H))-10);
%     ylabel('Magnitude');xlabel('Frequency');
%     set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000]')
%     %set(gca,'YTick',[-10 -5 0  ]') % dB scale
%     set(gca,'YTick',[-100 -50 0  ]') % dB scale
%     %axis([20 20000 -10 1])  %Scaling of axes
%     axis([45 22500 -100 10])  %Scaling of axes
%     ylabel('Magnitude');xlabel('Frequency')
%     hold on
    
    % Initialize output arguments 
    Bdiff = zeros(3,N-1);
    Adiff = zeros(3,N-1);
    Acolor = cell(1,N);
    Bcolor = cell(1,N);
    Acolor(: ,1) = {H1A};
    Bcolor(: ,1) = {H1B};

    % calculate and plot the coloration filter of each segment 
    for n = 1 : N-1 
%         offset = 10 + n * 2;
        [atot, btot] = diffFiltCoeff(fb(n), fc(n), G(n), fs);
%         [H1,W1] = freqz(btot,atot);
%         H1 = H1 ./ H1(1);
        %semilogx(W1*fs/(2*pi), mag2db(abs(H1)));
        %plot(W1*fs/(2*pi), mag2db(abs(H1)));
%         hold on

        b1 = conv(H1B,btot);
        a1 = conv(H1A,atot);
        
%         [H1,W1] = freqz(b1,a1);
%         H1 = H1 ./ H1(1);
%         semilogx(W1*fs/(2*pi), mag2db(abs(H1)));
%         hold on

        Bdiff(:,n) = btot;
        Adiff(:,n) = atot;
        Acolor(: ,n+1)  = {a1};
        Bcolor(: ,n+1)  = {b1};

        H1B = b1;
        H1A = a1;

    end

%     hold off
    
end

