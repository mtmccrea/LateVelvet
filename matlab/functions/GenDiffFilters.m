function [Adiff, Bdiff, Acolor, Bcolor] = genDiffFilters(H1A, H1B, N, fc_range, fb_range, G_range, fs, LP )

    % [Adiff, Bdiff, Acolor, Bcolor] = GenDiffFilters(H1A,H1B,N,fc_range, fb_range, G_range ,fs, HS, HSfc, HSg )
    % INPUT 
    % H1A : numerator  filter coefficients of the all-pole filter
    % H1B : denominator filter coefficients of the all-pole filter
    % N : number of segments
    % fc_range : vector of centerfrequency range , 1x2 
    % fb_range : vector of bandwith range , 1x2 
    % G_range : vector of gain range, 1x2
    % fs : sample frequency [Hz]
    % LP : for == true, a LP filter is added to the filter cascade,
    %      following fc_range (not ideal for efficiency, currently LP is 14th order)
    % OUTPUT
    % Adiff : matrix of denominator filter coefficients , size(3,N-1)
    % Bdiff : matrix of numerator filter coefficients , size(3,N-1)
    % Acolor : cell of vectors of denominator all-pole filter coefficients, 1xN 
    % Bcolor : cell of vectors numerator of all-pole filter coefficients, 1xN
    %
    % This function uses the function diffFiltCoeff.m
    
    % create parameter ranges
    fc = linspace(fc_range(1), fc_range(2), N-1); 
    fb = linspace(fb_range(1), fb_range(2), N-1);  
    G  = linspace(G_range(1),  G_range(2),  N-1);

    % Initialize output arguments 
    Bdiff  = zeros(3,N);
    Adiff  = zeros(3,N);
    Acolor = cell(1,N);
    Bcolor = cell(1,N);
    Acolor(:, 1)  = { H1A };
    Bcolor(:, 1)  = { H1B };

    % initialize recursive filter
    b1 = H1B;
    a1 = H1A;  

    % calculate the coloration filter of each segment 
    for n = 1:N-1 
        % individual differential filter
        [atot, btot] = diffFiltCoeff(fb(n), fc(n), G(n), fs);
        Bdiff(:, n) = btot; % save for plotting
        Adiff(:, n) = atot;
        
        % full coloration filter (cascade) to be used on each segment
        b1 = conv(b1, btot);
        a1 = conv(a1, atot);
        Acolor(:, n+1) = { a1 }; % save for plotting
        Bcolor(:, n+1) = { b1 };
    end

    if LP == true
        for m = 2:N
            lpFilt = designfilt('lowpassfir',...
                'FilterOrder', 14, ...
                'CutoffFrequency', fc(m-1)+2000, ...
                'SampleRate', fs ...
            );
            b2 = conv(Bcolor{m}, lpFilt.Coefficients);
            Bcolor(:, m) = { b2 };
        end
    end
end
