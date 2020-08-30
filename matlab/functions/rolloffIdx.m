function [idxs, freqs, vals] = rolloffIdx(mags, rolloff, min_freq, Fs)
    % idxs = rolloffIdx(mags, rolloff, min_freq, Fs)
    %   INPUTS
    %            mags : column-major matrix of NORMALIZED spectral magnitudes
    %         rolloff : dB level to search for in rolloff countour
    %        min_freq : search above this frequency (shrink the search space)
    % freq_resolution : number of points comprising the full magnitude
    %                   spectrum
    %              Fs : sample rate
    %   OUTPUTS
    %       idxs : vector of indicies closest to the rolloff
    %      freqs : frequencies at idxs
    %       vals : values in mags matrix at indxs
    
    % narrow the search space: omit part of the spectrum below min_freq
    nFreqs = length(mags);
    minFrqIdx = floor(min_freq/(Fs/2) * nFreqs);
    srchSpec = mags(minFrqIdx:end, :);
    
    % find closest values with their index
    [d, mindex] = min(abs(srchSpec - rolloff));
    
    % restore index from min_freq offset
    idxs = mindex + minFrqIdx-1;    
    
    %     cols = 1:size(mags, 2);
    %     freqs = sub2ind(size(mags), idxs, cols);
    %     freqs = w(ix)/pi * (Fs/2);
    freqs = Fs/2 / nFreqs * (idxs-1);
    
    vals = mags(idxs); % cutoff values in each segment
end