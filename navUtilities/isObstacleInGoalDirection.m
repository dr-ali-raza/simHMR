% isObstacleInGoalDirection finds whether obstacle is present in the path of goal 
%
% University of Engineering and Technology, Lahore
% =========================================================================
% For navigating in ustructured envirnment, we need to know whether there
% is obstacle in the path of goal. If there is no obstacle, no navigation
% scheme is required and vice versa.
% -------------------------------------------------------------------------
% Input Variable:
%   gDir: heading direction towards goal
%   senOrien: orientations of installed sensors
%   obsDist -> distance of obstacles from each sensor
%   senRange -> range of distance sensors
% Output Variable:
%   flag: flag = 1, if there is obstacle in the path to goal otherwise 0
%   rDir: returns the value of robot heading if there is no obstacle in
%   goal direction
% =========================================================================

function [flag, rDir] = isObstacleInGoalDirection(gDir, senOrien, obsDist, senRange)

thetamat=abs(senOrien-gDir);
[m,n]=min(thetamat);
rDir = senOrien(n);

th_mod = obsDist - senRange;
y = find(th_mod);       % find linear indices of non-zero element
res = find(y == n);     % 
[a, b] = size(res);

if b == 0
    flag = 0;
else
    flag = 1;
end

end