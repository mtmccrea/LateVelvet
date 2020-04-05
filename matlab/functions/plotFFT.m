function plotFFT(signal, N, Fs)
%   plotOneFFT(signal, N, Fs)

    zoom = [0 Fs/2];         % "zoom in" on this freq range
    H = fft(signal, N);
    mag = abs(H)*2/N;
    mag = fftshift(mag);
    
    % the plot indices of freqbins (of fftshifted spectrum)
    pidx = (floor(N/2)+1:N); % spectrum 0 -> Nyquist
    mag = mag(pidx);
    mag = mag2db(mag);
    f = linspace(0, Fs/2, length(mag));
    
    semilogx(f, mag);
    xlim(zoom);              % zoom via plot limits
end