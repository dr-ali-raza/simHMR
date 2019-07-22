% this function calculates the goal direction from robot with given robot
% position (rPos) and goal position (gPos)
% returns angle in the range of pi to -pi
function angle = thetaG(rPos, gPos)

% evaluating midpoint of the given goal
xGoal = gPos(2) + gPos(4)/2;
yGoal = gPos(3) + gPos(5)/2;

%angle = atan2(yGoal-rPos(2), xGoal-rPos(1));
angle = cart2pol(xGoal-rPos(1), yGoal-rPos(2));
end