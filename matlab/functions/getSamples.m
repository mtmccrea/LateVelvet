function Y = getSamples(X, st, N)
    % getSamples(X, st, N)
    %    [input]
    %  X: signal buffer
    % st: start sample of returned frames
    %  N: number of samples to return
    if st+(N-1) > length(X)
        warning('requested samples exceed the length of ht input buffer, clamping at the end');
        N = length(X) - st;
    end
    Y = X(st:st+N-1);
end