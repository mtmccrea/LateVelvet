

function [a_diff,b_diff] = diffFiltCoeff(fb, fc, G, fs) 

    % [atot, btot] = diffFiltCoeff(fb, fc, G, fs)
    % INPUT
    % fb : vector of bandwiths , size(1,N)
    % fc : vector of centerfrequencies , size(1,N)
    % G : Notch gain [dB]
    % fs : sample frequency [Hz]
    %
    % OUTPUT 
    % a_diff : vector of denominator filter coefficients , size(1,3)
    % b_diff : vector of numerator filter coefficients , size(1,3)

    lengthfb = length(fb); % equals  N 
   
    V0 = db2mag(G);

    for i = 1 : lengthfb

        c = (tan(pi*fb(i)/fs)-V0)/(tan(pi*fb(i)/fs)+V0);

        d = -cos(2*pi*fc(i)/fs);

        % filter coefficient with the structure of an all pole filter

        b = [-c  d*(1-c) 1];
        a = [1 d*(1-c) -c];

        % calculating the filter coefficients for the notch filter

        V = V0 - 1 ;
        b_diff = (2 + V) * a - V * b ;
        a_diff = 2 * a ;


    end
end


