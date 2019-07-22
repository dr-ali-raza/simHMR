function inflamation = CalculateInflamation(pTrace, cTrace, stepSize, noOfSteps)
%CalculateInflamation calculate the inflamation value for current
% concentration of Anti-bodies. Based on calculated value, new generation
% of anti-bodies will be generated 
%--------------------------------------------------------------------------
% Input Variable:
%   pTrace -> contains the trace of position of robot
%   cTrace -> trace of collisions that robot makes with obstacles
%   stepSize -> step size that robot takes in each step (rho1)
%   noOfSteps -> number of steps for which we want to evaluate inflamation
% Output Variable:
%   inflamation -> value of inflamation
%==========================================================================
% Sample Function Callings:
% 1. inflam =  CalculateInflamation(posnTrace, collTrance)
% >>
%--------------------------------------------------------------------------

% Local Variables
Woa = 0.5; % weight for obstacle avoidance
Wts = 0.5; % weight for target seeking
[m, totalSteps] = size(pTrace); % number of steps that robot have taken

% Evaluating Inflamation due to robot distance covered
%--------------------------------------------------------------------------
d = findDist(pTrace(:, totalSteps), pTrace(:, totalSteps-noOfSteps));

inflamation_dist = d/(stepSize*noOfSteps);
inflamation_obs = 0;
% inflamation_obs = 1;

inflamation = 1 - (Woa*inflamation_dist + Wts*inflamation_obs);
% inflamation = (Woa*inflamation_dist + Wts*inflamation_obs);
end