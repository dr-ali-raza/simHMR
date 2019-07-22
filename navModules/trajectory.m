%% Synopsis
% t = trajectory(type, x1, y1, x2, y2, dp)
% Function Name = Trajectory
% This function generate data points of the trajectory specified by the 
% 'type' using rest of the input arguments.
%
% Inputs:
% type = It defines the type of trajectory to be generated. 
% 'p' = Single point: x1 = x-coordinate, y1 = y-coordinate, rest of the 
% input arguments are not needed.
% 'l' = Line: (x1,y1) = starting coordinates of line, (x2,y2) = Ending
% coordinates of the line, dp = number of Data Points in the generated
% Line.
% 'c' = Circle: (x1,y1) = center of the circle, x2 = radius of the circle,
% y2 = dp = number of Data Points in the generated circle.
% 
% Output:
% t = An nx2 matrix containing data points of the generated trajectory.

%% Function Definition
function t = trajectory(type,x1,y1,x2,y2,dp)
switch type
    case 'p'        % Generation of Single Point as Trajectory
        y2 = 0;
        t = [ones(x2,1).*x1 ones(x2,1).*y1];
    case 'c'        % Generation of Circle as Trajectory
        r = x2;
        dp = y2;
        [x,y] = circle1([x1,y1],r,dp,[1 1 1]);
        t = [x', y'; x', y'];
    case 'l'        % Generation of Line as Trajectory
        x = linspace(x1,x2,dp);
        y = linspace(y1,y2,dp);
        t = [x', y'];
    case 'pp'        % Generation of Line as Trajectory
        x = linspace(x1,x2-80,dp-10);
        y = linspace(y1,y2,dp-10);
        y1 = linspace(y(end),y(end)+80,10);
        t = [x', y'; x(end)*ones(10,1),y1'];
end