function points = DiffDriveModel(rho1, step, posn)
% DiffDriveModel evaluates the trajectory points for a Differential Drive Robot
% Detailed explanation goes here
%
% Written by Shujat Ali, (c) 2017
% mshujatali@gmail.com
%
% University of Engineering and Technology, Lahore, Pakistan
%--------------------------------------------------------------------------
% Input Variable:
%   rho1 -> number of steps that robot takes in one iteration
%   step -> step size that robot take in each step
%   posn -> contains initial condition of robot [x0, y0, theta0]
% Output Variable:
%   points -> points on which robot should move
% =========================================================================

global wheelV

% Differential equation solution
tspan = 1:step:rho1;
y0 = [posn(1), posn(2)]; % initial condition

[T, Y] = ode45(@DiffDriveModelEq, tspan, y0);

points = Y;

end