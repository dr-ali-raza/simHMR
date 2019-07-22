function [wheelVL, wheelVR] = ExtractFeatures4DiffDrive(posn, theta, rho1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
vmax = rho1;
vmin = -rho1;

thetaDiff = posn(3) - theta;

if (thetaDiff == 0)
    wheelVL = vmax;
    wheelVR = vmax;
elseif (

end