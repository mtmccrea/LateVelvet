function [mags, mags_norm, freqs, coeffs] = lpcData(signal, lpc_order, freq_resolution, Fs, whiten)
    % [mags freqs coeffs] = lpcData(signal, lpc_order, freq_resolution, whiten)
    %            INPUT
    %           signal : column-major input signal matrix
    %        lpc_order : order of LPC filter to generate
    %  freq_resolution : number of frequencies to evaluate the magnitude 
    %                    spectrum
    %               Fs : sample rate
    %           whiten : optional flag to perform freq analysis on the LPC
    %                    coefficients treated as a whitening filter
    %    OUTPUT
    %      mags : frequency magnitudes of the spectral estimate in dB
    % mags_norm : normalized frequency magnitudes of the spectral estimate in dB
    %     freqs : frequencies corresponding to the spectral magnitudes
    %    coeffs : the LPC coefficients
    
    % enforce column vector on 1-channel signal
    if size(signal, 1) == 1
        signal =  signal';
    end
    % handle whitening option
    whitenfilt = false; % default: analyse a whitening filter
    if nargin > 4
        if whiten > 0
            whitenfilt = true;
        end
    end
    
    coeffs = lpc(signal, lpc_order)'; % note: column-major
    nchan = size(signal, 2);
    mags = zeros(freq_resolution, nchan);
    mags_norm = zeros(freq_resolution, nchan);
    freqs = zeros(freq_resolution, 1);
    % 
    for i = 1:nchan
        if whitenfilt
            [H, w] = freqz(coeffs(:, i), 1, freq_resolution);
        else
            [H, w] = freqz(1, coeffs(:,i), freq_resolution);
        end
        m = abs(H);
        mags_norm(:, i) = mag2db(m./max(m));
        mags(:, i) = mag2db(m);
    end
    freqs(:,1) = (w/pi) * (Fs/2);
end