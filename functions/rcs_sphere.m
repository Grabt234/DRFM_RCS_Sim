function [rcs_db] = rcs_sphere (a,freqGH)
% This program computes the back-scattered RCS for an ellipsoid.
% The angle phi is fixed, while the angle theta is varied from 0-180 deg.
% Inputs    
% a     == sphere a-radius in meters      
%Output    
% rcs   == ellipsoid rcs versus aspect angle in dBsm

% Generate aspect angle vector
theta = -90.:.05:90;

rcs = pi * a^2;      

rcs_db = 10.0 * log10(rcs);

figure
rcs_db = repmat(rcs_db,1,length(theta));
plot(theta, rcs_db);
title (['RCS of a Perfectly Conducting Metal Sphere Illuminated by a Vertically Polarized Wave,  ','Frequency = ',num2str(freqGH),'  GHz, ', '  R = ', num2str(a), ' m']);
ylabel ('Sphere RCS(dbm)');
xlabel ('Aspect angle(deg)');
grid on
return
