function Y = schrdAllpass(X, g, M)
    % schrdAllpass(X, g, M)
    %       [input]
    %   X: input signal
    %   g: feeback/forward gain coefficient
    %   M: delay in samples
    %       [output]
    %   Y: output signal, equal in size to X (TBD)
    
    N = length(X);
    tap = N-(M-1);     % delay pointer

    Y = zeros(N,1);    % output buffer
    for n=1:N
        Y(n) = (-g*X(n)) + (g*Y(tap)) + X(tap); % DAFX, 2nd ed. eq. 5.19
        tap = tap+1;
        if tap>N; tap = 1; end  % wrap delay pointer
    end
end
