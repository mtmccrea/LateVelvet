function Y = velvet(N, f, Fs)
    % velvet(N, f, Fs)
    %       [input]
    %   N: size of signal to generate
    %   f: frequency (pulse density) of VN sequence
    %  Fs: Samplerate
    %       [output]
    %   Y: output signal, length N
    
    %  freq (pulse density) in Hz
    T = Fs/f;  % pulse period
    nPulse = N/T;
    
    Y = zeros(N, 1);
    % determine pulse location (Välimäki, et al, Eq. 2 & 3)
    % m needs to start at 0
    for m = 0:nPulse-1
        km = round( (m*T) + rand()*(T-1) );
        Y(km+1) = 2 * round(rand()) - 1;
    end
end

% See:
% Välimäki, V., Holm-Rasmussen, B., Alary, B., & Lehtonen, H.-M. (2017). 
% Late Reverberation Synthesis Using Filtered Velvet Noise. 
% Applied Sciences, 7(5), 483. https://doi.org/10.3390/app7050483
