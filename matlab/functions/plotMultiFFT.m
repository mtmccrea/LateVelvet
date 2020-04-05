function plotMultiFFT(signalCell, N, Fs)
    % plotMultiFFT(signalCell, N, Fs)
    %    INPUT
    % signalCell: a cell array containing signals to perform FFT
    %          N: FFT size
    %         Fs: sample rate of signal
    
    mags = zeros(N, length(signalCell)); % matrix to hold FFT analysis
    
    % "zoom in" on this freq range (via xlim)
    % Change this is you want a specific freq range
    zoom = [0 Fs/2];                     
    
    nSig = length(signalCell);
    for i=1:nSig
        mags(:,i) = fft(signalCell{i}, N);
    end
    mags = abs(mags)*2/N;
    mags = fftshift(mags);    
    
    % the plot indices of freqbins (of fftshift'd spectrum)
    pidx = (floor(N/2)+1:N);        % spectrum 0 -> Nyquist
    mags = mags(pidx, :);
    mags = mags./max(max(mags));    % normalize spectra
    mags = mag2db(mags);
%     mags = mags./max(mags);
    
    f = linspace(0, Fs/2, length(mags)); % bin frequencies 
    semilogx(f, mags);
    xlim(zoom);
    ylim([-80 0]);
end