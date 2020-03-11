function filterplot(Bcolor,Acolor,Bdiff,Adiff,fs)

% filterplot(Bcolor,Acolor,Bdiff,Adiff,fs)
% INPUT
%Bcolor : cell with numerator coefficients of colorisation filter
%Acolor : cell with denominator coefficients of colorisation filter
%Bdiff : vector with numerator coefficients of differential filter
%Adiff : vector with denominator coefficients of differential filter
% fs   : sample frequency [Hz]

    [H,W] = freqz(Bcolor{1},Acolor{1});
    H = H ./ H(1);
    figure(1);
    subplot(3,1,1)
    semilogx(W*fs/(2*pi), mag2db(abs(H)));
    ylabel('Magnitude');%xlabel('Frequency');
    set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000]')    % Frequency points
    set(gca,'YTick',[-100 -50 0  ]') % dB scale
    axis([45 22500 -100 10])  %Scaling of axes
    hold off
    
      %plot the notch filters for each segment 
    subplot(3,1,2)

    for n = 1 : size(Adiff,2)
        [H1,W1] = freqz(Bdiff(:,n),Adiff(:,n));
        semilogx(W1*fs/(2*pi), mag2db(abs(H1)));
        H1 = H1 ./ H1(1);
        hold on 

    end
 ylabel('Magnitude');%xlabel('Frequency');
    set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000 ]')    % Frequency points
    set(gca,'YTick',[-10 -5 0  ]') % dB scale
    axis([45 22500 -8 1])  %Scaling of axes

 % plot the estimated frequency response for 1. segment 
    subplot(3,1,3)
    semilogx(W*fs/(2*pi), mag2db(abs(H)));

    hold on              
       
               for n = 1 : size(Acolor,2)
        [H2,W2] = freqz(Bcolor{n},Acolor{n});
        H2 = H2 ./ H2(1);
        semilogx(W2*fs/(2*pi), mag2db(abs(H2)));
         offset= 10 + n * 2;
        hold on 

        end
            

    ylabel('Magnitude');xlabel('Frequency');
    set(gca,'XTick',[125 250 500 1000 2000 4000 8000 16000]')    % Frequency points
    set(gca,'YTick',[-100 -50 0  ]') % dB scale
    axis([45 22500 -100 10])  %Scaling of axes
    hold off
end
