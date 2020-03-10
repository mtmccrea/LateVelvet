function Y = velvet(N, f, Fs, ensureLast)
    % velvet(N, f, Fs)
    % INPUT
    %          N : size of signal to generate
    %          f : frequency (pulse density) of VN sequence
    %         Fs : Samplerate
    % ensureLast : (optional) boolean. If pulse period doesn't divide
    %              evenly into N, force the last pulse to occur within the
    %              last window regardless of its size
    %
    % OUTPUT
    %   Y : output signal, length N
    
    %  freq (pulse density) in Hz
    T = Fs/f;        % pulse period
    nP = ceil(N/T);  % number of pulses to generate
    Y = zeros(N, 1); % output signal
    
    % calc pulse location (Välimäki, et al, Eq. 2 & 3)
    for m = 0:nP-1                              % m needs to start at 0
        p_idx = round((m*T) + rand()*(T-1));    % k_m, location of pulse within this pulse period
        if (p_idx <= N)                         % make sure the last pulse is in bounds (in case nP was fractional)
            Y(p_idx+1) = 2 * round(rand()) - 1; % value of pulse: 1 or -1
                                                % p_idx+1: bump from 0- to 1-based indexing
        elseif nargin > 3
            if ensureLast
                p_idx = round((m*T) + rand()*(T-1-mod(N,T)));
                Y(p_idx+1) = 2 * round(rand()) - 1; 
                disp('forcing last pulse within bounds')
            end
        end                                           
    end
end

% See:
% Välimäki, V., Holm-Rasmussen, B., Alary, B., & Lehtonen, H.-M. (2017). 
% Late Reverberation Synthesis Using Filtered Velvet Noise. 
% Applied Sciences, 7(5), 483. https://doi.org/10.3390/app7050483
