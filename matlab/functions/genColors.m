function rgb = genColors(hue_start, hue_span, num_cols)
    % genColors(hue_start, hue_span, num_plots)
    %      INPUT
    %  hue_start : hue start position {0,1}
    %   hue_span : hue range {0,1}
    %   num_cols : number of colors to generate
    hue = linspace(hue_start, hue_start+hue_span, num_cols); % hue
    sat = linspace(1, 1, num_cols);     % saturation
    val = linspace(0.2, 1, num_cols);   % value
    hsv = [hue' sat' val']; 
    rgb = hsv2rgb(hsv);
end