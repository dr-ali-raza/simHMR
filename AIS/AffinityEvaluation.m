function [abbsAffinity, headingDir] = AffinityEvaluation(abbs, robPosn, goalPosn, dist_o, obstacles, arrena, robStep, th, CVM_param)
%AffinityEvaluation (cost estimation) function evaluate the affinity of
%each anti-body by taking robot\goal current position and robot parameters
%represented by anti-body bistring.
%--------------------------------------------------------------------------
% Input Variable:
%   abbs -> bitstring represention (antibody) of sensors, actuators,
%   control and planning
%   robPosn -> current position of robot [colNo, rowNo, angle]
%   goalPosn -> global targets in arrena, [tarNo, colNo, rowNo, xSpan, ySpan]
%   dist_o -> distance of obstacle from the robot
%   obstacles -> obstacles matrix []
%   cvm_param -> [tv_max, rv_max, ta_max, ra_max]
%   robStep -> step size of robot (rho)
%
% Output Variable:
%   abbsAffinity -> (cost function value) affinity of given anti-body
%   represented by abbs
%==========================================================================
% Sample Function Callings:
% [abbsAff, dir] = AffinityEvaluation('11000001100100010110100010001001',
% ... [250, 150, 0], [1, 450, 350, 50, 50], [], [], [], rho)

% Used Variables and Constants
%--------------------------------------------------------------------------
global sBinStr_l sDep sSpan
dir = robPosn(3);
th_g = goalDirection(robPosn, goalPosn);

gdW = 0.6;      % weight for Goal Distance parameter
odW = 0.4;      % weight for Obstacle Distance parameter
edW = 0.15;     % weight for Effective Distance parameter
caW = 0.15;     % weight for Collision Avoidance parameter

% Decoding Anti-body Bitstring
%--------------------------------------------------------------------------
[sensNo, sensRange, sensSpan, wheelModel, controlType, planAlgo] = abbs2spac(abbs);

sensSpan = sensSpan*2*pi/360;
sBinStr_l = sensNo; % number of sensors
sDep = sensRange; % range of sensors
sSpan = sensSpan; % span of sensors

% Apply Navigation Schemes
%--------------------------------------------------------------------------
if (strcmp(planAlgo, 'RIN'))
    headingDir = RIN(sSpan, th_g, dist_o, th);
elseif (strcmp(planAlgo, 'SSHT'))
    headingDir = SSHT(robPosn, th, dist_o, sDep, robStep, arrena, goalPosn);
elseif (strcmp(planAlgo, 'CVM'))
    %headingDir = VFH(robPosn, dist_o, th, sDep, goalPosn, sSpan);
    %headingDir = CVM(CVM_param, robPosn, obstacles, dist_o, th, goalPosn, th_g);
    headingDir = CVM(CVM_param, robPosn, obstacles, dist_o, th, goalPosn, th_g);
else
    %exception handling
end

% Affinity Parameters Evaluation
%--------------------------------------------------------------------------
% calculate the next position of robot
[prx, pry] = pol2cart(headingDir, robStep);
robPosn_next = [robPosn(1)+prx, robPosn(2)+pry, headingDir];
% Goal Distance Change - How much closer to goal the robot will get
affGoalDist = gdW*(findRDist(robPosn_next, goalPosn)... % current distance from goal
- findRDist(robPosn, goalPosn))/robStep; % previsous distance from goal

% Obstacle Avoidance - How much away from the obstacles the robot will move
th_diff = sSpan - abs(th);
th_diff = abs(th_diff);
[C, I] = min(th_diff);
th_obs = dist_o(I);
affObsDist = odW*(th_obs - sDep)/sDep;

% Effective Distance Covered - in last 2 steps (or 1 last and 1 current)


% Anti-body Affinity
%--------------------------------------------------------------------------
abbsAffinity = affGoalDist + affObsDist;

end