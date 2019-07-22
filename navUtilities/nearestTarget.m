% nearestTarget finds target, from 'targets' matrix, nearest to robot 
% Written by Shujat Ali, mshujatali@gmail.com
%
% University of Engineering and Technology, Lahore
% =========================================================================
% For multi-targets arrena, robot need to find targets one by one.
% Therefor we need to find the target closest to robot for efficient
% navigation. Target having least distance from robot will be assigned as
% current target.
% Note: For single target arrena, it will return the same target.
% -------------------------------------------------------------------------
% Input Variable:
%   rLoc: Robot's current location, [x, y, theta]
%   targets: matrix containing all the targets in arrena
%
% Output Variable:
%   curTarget: target nearest to robot
% =========================================================================

function [ curTarget] = nearestTarget(rLoc, targets)

noOfGoals = size(targets, 1);
goalDistances = zeros(1, noOfGoals);

% find distance of each target from robot
for i = 1:noOfGoals
    cGoal = targets(i, :);
    xGoal = cGoal(2) + cGoal(4)/2;
    yGoal = cGoal(3) + cGoal(5)/2;
    goalDistances(i)= sqrt((yGoal-rLoc(2))^2+(xGoal-rLoc(1))^2);
end

% target with least distance will be assigned as current target
[m, n] = min(goalDistances);
curTarget = targets(n, :);
        
end