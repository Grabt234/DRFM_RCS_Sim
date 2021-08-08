%%
%--------------------------------------------------------------------------
% Matlab code investigating RCS Shape Evaluation

% Plot the Radar Cross Section (RCS) radiation patterns for both a sphere 
% and a flat plate at f= 12.5 GHz. The patterns  should  cover  aspect  
% angles  relative  to  the  peak  (or  bore  sight)  with θ∈(-90° :90°)  
% in  either  the vertical  or  horizontal  plane.  The  sphere  has  a  
% radius  of  0.75  m.  The  flat  plate  is  square  with  a  height  
% (or width) of 0.4 m and thickness of 5 mm. Compare your results for each
% shape and recommend a shape to be used for RCS reduction.Also recommend 
% a shape for calibrating a radar.  Be sure to give reasons why you would 
% choose the one shape over the other
%--------------------------------------------------------------------------

%%
a = 0.4;
b = 0.4;
freq = 12.5e9;
freqGH = 12.5;

[rcs] = rcs_rect_plate(a, b, freq);

% phi = 0;

c = 0.75

% 
[rcs] = rcs_sphere(c,freqGH)