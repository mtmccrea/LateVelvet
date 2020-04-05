function plotSTFT(X, N, hop, Fs)
%  plotSTFT(X, N, hop, Fs)
    stft(X, Fs, ...
        'Window', kaiser(N/4,5), ...
        'FFTLength', N, ...
        'Centered', false ...
        );
    colormap(flipud(bone))
    hold on;
end