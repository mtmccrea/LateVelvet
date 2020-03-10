function [a,b] = firstordShelfcoeff(G,wc,HS)

% This function filters the signal X with a low shelf or high shelf filter 
% and stores it to the output signal Y. It returns as the filter
% coefficients as well. 
% 
% Input:
% - G is the gain in dB 
% - wc is the cross-over frequency in radians 
% - set HS = true for the High-Shelf mode
%
% Output: 
% - a is the filter coefficient vector for the denominator
% - b is the filter coefficient vector for the numerator 
%
%
% The function is based on the first order low shelf filter derived in 
% the review article: 
% V. Valimaki and J. D. Reiss, "All About Audio Equalization: Solutions 
% and Frontiers", Applied Sciences, 2016
%

if HS == true 
    wc = pi - wc; %adapt the crossover frequency in High-Shelf-mode
end;

a0 = tan(wc/2) + sqrt(G);  % calculate filter coefficient 
a1 = (tan(wc/2) - sqrt(G)); % calculate filter coefficient 
b0 = (G*tan(wc/2) + sqrt(G)); % calculate filter coefficient 
b1 = (G*tan(wc/2) - sqrt(G)); % calculate filter coefficient 

% 3.1) create normalized coefficents 

a1 = a1 / a0; % normalize filter coefficient 
b0 = b0 / a0;  % normalize filter coefficient 
b1 = b1 / a0;  % normalize filter coefficient 


if HS == true 
     a1 = -a1; %adapt the coefficient sign in High-Shelf-mode
      b1 = -b1; %adapt the coefficient sign in High-Shelf-mode
end;

a = [1 a1]; % create the coefficent vector 
b = [b0 b1]; % create the coefficient vector 

end 
