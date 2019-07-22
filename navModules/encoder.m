%%
% Synopsis
% encoder function gives angular displacement of a rotating object.
% Input:
% pCount = Count of Pulses in unit time
% resol = Resolution of the encoder, i.e. pulses per degree rotation
% utime = Unit time
% 
% Output:
% angDist = Angular Distance traversed by the rotating object
% angVel = Angular velocity of the rotating object
%
%Written By: Muhammad Rzi Abbas
%%
function [angDist, angVel] = encoder(pCount,resol,utime)
angDist = pCount/resol;
angVel = angDist/utime;
end