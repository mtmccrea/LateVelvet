function Y = apCascade(X, a, d, rolloff_threshold)
    % Y = apCascade(X, a, d, rolloff_threshold)
    % Process a signal X with a cascade of Schroeder all-pass filters
    %
    % INPUT
    % X : input signal
    % a : all-pass coefficient
    % d : vecor of delays in samples. determines cascade order.
    % rolloff_threshold : (optional) this will determine the length of the returned signal, based on 
    %       and energy decay tail cutoff point. 
    %       If omitted, signal is truncated to size of X
    %       Note: the method is Quite crude, as underlying calculation assumes low order filters...
    %
    % OUTPUT
    % Y : ouput signal, size is the same as X, unless rolloff_threshold is
    %     specified
 
    Y = X;
    
    if nargin < 4
        for del = d
            Y = schrdAllpass(Y, a, del);
        end 
    else
        for del = d
            Y = schrdAllpass(Y, a, del, rolloff_threshold);
        end
    end
end