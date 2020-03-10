function Y = schrdAllpass(X, g, M, rolloff)
    % schrdAllpass(X, g, M)
    %   INPUT
    %   X : input signal
    %   g : feeback/forward gain coefficient
    %   M : delay in samples
    %   rolloff : (optional) threshold in dB decay to trim the returned 
    %             buffer. Default -60 dB (~99.9% energy).
    %   OUTPUT
    %   Y : output signal, same size as X, unless rolloff is specified
    
    % calculate group delay of an IIR filter
    %     Välimäki, V., Abel, J. S., & Smith, J. O. (2009). 
    %     Spectral Delay Filters. J. Audio Eng. Soc., 57(7/8), 521?531.
%     delay = (1 - g^2) ./ (1 +  2*g*cos(omega) + g^2);

    % Calculate the length of the resultant IR based on % energy decay of
    % first-order all-pass
    if nargin < 4
        thresh = -60;                 % threshold in dB, -60 ~ 99.9%
    else
        thresh = rolloff;
    end
    P = 1 - db2mag(thresh); % percent of energy decay [0,1]
    delay = (log(1 - P) - log(1-g^2)) / log(g^2); % - 1;
    delay = ceil(delay * M); % account for AP order
    delay = ceil(delay * 1.35); % magic number 
    display(...
        "IR length at " + (round(P, 1)) + "% decay: "+round(delay)+ " samples")

    xN = length(X);
    if nargin < 4
        outN = xN;
    else
        outN = xN + delay;
    end
    Y = zeros(outN, 1);    % output buffer
    
    % pad the input to match output size
    pad = zeros(outN-xN, 1);
    X = [X; pad];
    tap = outN-(M-1);     % delay pointer    
    
    for n=1:length(Y)
        Y(n) = (-g*X(n)) + (g*Y(tap)) + X(tap); % DAFX, 2nd ed. eq. 5.19
        tap = tap+1;
        if tap>outN; tap = 1; end  % wrap delay pointer
    end
end
