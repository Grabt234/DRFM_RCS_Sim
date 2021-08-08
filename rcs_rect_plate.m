function  [rcsdb_v] = rcs_rect_plate(a, b, freq)
% This program computes the backscattered RCS for a rectangular 
% flat plate. The RCS is computed for vertical and horizontal
% polarization based on Eq.s(14.52)through (14.62). Also Physical
% Optics approximation Eq.(14.64) is computed.
% User may vary frequency, or the plate's dimensions.
% Default values are a=b=10.16cm; lambda=3.25cm.


%% 0 < Theta < 80
eps = 0.000001;
% Enter a, b, and lambda
lambda = 3e8/freq;
ka = 2. * pi * a / lambda;
% Compute aspect angle vector
theta_deg = -88:0.1:88;
theta = (pi/180.) .* theta_deg;

sigma1v = cos(ka .*sin(theta)) - i .* sin(ka .*sin(theta)) ./ sin(theta);sigma2v = exp(i * ka - (pi /4)) / (sqrt(2 * pi) *(ka)^1.5);
sigma3v = (1. + sin(theta)) .* exp(-i * ka .* sin(theta)) ./ ...  
 (1. - sin(theta)).^2;sigma4v = (1. - sin(theta)) .* exp(i * ka .* sin(theta)) ./ ... 
  (1. + sin(theta)).^2;
sigma5v = 1. - (exp(i * 2. * ka - (pi / 2)) / (8. * pi * (ka)^3));

% Compute vertical polarization RCS
rcs_v = (b^2 / pi) .* (abs(sigma1v - sigma2v .*((1. ./ cos(theta)) ...  
 + .25 .* sigma2v .* (sigma3v + sigma4v)) .* (sigma5v).^-1)).^2 + eps;

%% 80 < Theta < 90

%eq: 14.63
rcs_v_90 = (a*b^2/lambda)*((1 + pi/(2*(2*a/lambda)^2)) + (1 - pi/(2*(2*a/lambda)^2))*cos(2*ka - 3*pi/5))
10*log10(rcs_v_90)


%%
rcsdb_v = 10. .*log10(rcs_v);


figure
plot (theta_deg, rcsdb_v);
freqGH = num2str(freq*1.e-9);A = num2str(a);B = num2str(b);
title (['RCS of Flate Square Plate Illuminated by a Vertically Polarized Wave,  ','Frequency = ',[freqGH],'  GHz, ', '  L = ', [A], ' m']);
ylabel ('Rectangular plate RCS(dBsm)');
xlabel ('Aspect angle(deg)');
grid on

end