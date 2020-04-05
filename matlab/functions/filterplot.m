function filterplot(Bcolor, Acolor, Bdiff, Adiff, fs, gain_offsets)

% filterplot(Bcolor,Acolor,Bdiff,Adiff,fs)
%   INPUT
% Bcolor : cell with numerator coefficients of colorisation filter
% Acolor : cell with denominator coefficients of colorisation filter
% Bdiff  : vector with numerator coefficients of differential filter
% Adiff  : vector with denominator coefficients of differential filter
% fs     : sample frequency [Hz]

rgb = genColors(0.3, 0.1, length(gain_offsets));
xtk = 125 * 4.^(0:7);       % freq ticks
ytk = [-100 -50 0];         % magnitude ticks [db]
axs = [50 fs/2 -100 10];    % freq bounds, mag bounds
ylbl = 'Magnitude [dB]';    % y-axis label
linew = 1.1;                % plot line width
pltw = 750;                 % subplot width
plth = 350;                 % subplot height
    
% LP spectral estimate for H1
subplot(3,1,1)
[H, W] = freqz(Bcolor{1}, Acolor{1});
H = H ./ H(1);
frqs = W*fs / (2*pi);

semilogx(frqs, mag2db(abs(H)) + gain_offsets(1),...
    'Color', rgb(1,:), 'LineWidth', 1.2);

% ylabel(ylbl);
axis(axs);
set(gca,'XTick', xtk, 'YTick', ytk);
set(gcf,'position',[300, 200, pltw, plth])
plotSettings();
hold off;

% Differential notch filters
subplot(3,1,2)
% hold on;
for n = 1:size(Adiff,2)
    [H1,~] = freqz(Bdiff(:, n), Adiff(:, n));
    H1 = H1 ./ H1(1);
    
    semilogx(frqs, mag2db(abs(H1)), ...
        'Color', rgb(n, :), 'LineWidth', linew);
    hold on;
end

ylabel(ylbl);
set(gca,'XTick', xtk, 'YTick', [-10 -5 0]);
yticks([-10 -5 0]);
axis([125 fs/2 -8 1])
set(gcf,'position',[300, 200, pltw, plth])
plotSettings();
hold off;


% Cascaded filter responses
subplot(3,1,3)
semilogx(frqs, mag2db(abs(H)) + gain_offsets(1),...
    'Color', rgb(1, :), 'LineWidth', linew);
hold on;
for n = 1 : size(Acolor,2)
    [H2,~] = freqz(Bcolor{n}, Acolor{n});
    H2 = H2 ./ H2(1);
    semilogx( ...
        frqs, mag2db(abs(H2)) + gain_offsets(n), ...
        'Color', rgb(n, :), 'LineWidth', linew ...
        );
end

% ylabel(ylbl); 
xlabel('Frequency [Hz]');
set(gca,'XTick', xtk, 'YTick', ytk);
axis(axs)
set(gcf,'position',[300, 200, pltw, plth])
plotSettings();
hold off;

align_Ylabels(); % align y-axis labels across subplots
end
