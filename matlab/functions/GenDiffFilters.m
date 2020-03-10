function [Adiff, Bdiff, Acolor, Bcolor] = GenDiffFilters(H1A,H1B,N,fc_range, fb_range, G_range ,fs, HS, HSfc, HSg )

    % [Adiff, Bdiff, Acolor, Bcolor] = GenDiffFilters(H1A,H1B,N,fc_range, fb_range, G_range ,fs, HS, HSfc, HSg )
    % INPUT 
    % H1A : numerator  filter coefficients of the all-pole filter
    % H1B : denominator filter coefficients of the all-pole filter
    % N : number of segments
    % fc_range : vector of centerfrequency range , 1x2 
    % fb_range : vector of bandwith range , 1x2 
    % G_range : vector of gain range, 1x2
    % fs : sample frequency [Hz]
    % HS : for == true , function cascades color filter with high shelf filter 
    % HSfc : HS cross over frequency [Hz]
    % HSg : HS gain 
    % OUTPUT
    % Adiff : matrix of denominator filter coefficients , size(3,N-1)
    % Bdiff : matrix of numerator filter coefficients , size(3,N-1)
    % Acolor : cell of vectors of denominator all-pole filter coefficients, 1xN 
    % Bcolor : cell of vectors numerator of all-pole filter coefficients, 1xN
    %
    % This function uses the function diffFiltCoeff.m
    
    
    % create parameter ranges
    fc = linspace(fc_range(2),fc_range(1), N-1); 
    fb = linspace(fb_range(2),fb_range(1), N-1);  
    G = linspace(G_range(2),G_range(1), N-1);

    % Initialize output arguments 
    Bdiff = zeros(3,N);
    Adiff = zeros(3,N);
    Acolor = cell(1,N);
    Bcolor = cell(1,N);
    Acolor(: ,1)  = {H1A};
    Bcolor(: ,1)  = {H1B};
    
    

    % calculate and plot the coloration filter of each segment 
    for n = 1 : N-1 
        
        [atot, btot] = diffFiltCoeff(fb(n), fc(n), G(n), fs);
        [H1,W1] = freqz(btot,atot);
        hold on
        b1 = conv(H1B,btot);
        a1 = conv(H1A,atot);
        Bdiff(:,n) = btot;
        Adiff(:,n) = atot;
        Acolor(: ,n+1)  = {a1};
        Bcolor(: ,n+1)  = {b1};
        H1B = b1;
        H1A = a1;
%    
    end

if HS == true 
   

            wc = 2*pi*fc/fs; % Crossover frequency in radians

            GH = db2mag(HSg); % convert HS gain to magnitude
             [aHS,bHS] = firstordShelfcoeff(GH,wc,HS); 
    for m = 2 : size(Acolor,2)
            
            a2 = conv(Acolor{m},aHS)
            b2 = conv(Bcolor{m},bHS)
            Acolor(: ,m)  = {a2};
            Bcolor(: ,m)  = {b2};
            
    end
end
