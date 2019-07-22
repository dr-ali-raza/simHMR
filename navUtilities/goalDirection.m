% goalDirection finds the angle of robot towards goal 
%
% University of Engineering and Technology, Lahore
% =========================================================================% With given robot position and goal location, this function will find the
% angle from robot to goal direction. (returns angle in range of pi to -pi)
% -------------------------------------------------------------------------
% Input Variable:
%   rPos: Poistion of robot, [x, y, theta]
%   gPos: Location of goal
%
% Output Variable:
%   gAngle: calculated angle of goal from robot
% =========================================================================

function angle = goalDirection(rPos, gPos)

% evaluating midpoint of the given goal
xGoal = gPos(2) + gPos(4)/2;
yGoal = gPos(3) + gPos(5)/2;

%angle = atan(yGoal-rPos(2)/xGoal-rPos(1));
angle = atan2(yGoal-rPos(2), xGoal-rPos(1));
%angle = cart2pol(xGoal-rPos(1), yGoal-rPos(2));

end