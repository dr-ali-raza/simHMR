% Function to clear plot robot in the arena with axes
% 
% University of Engineering and Technology, Lahore
% ========================================================================
% Input Variable:
%   h: handle to arena image object
%   posn: contains position of robot [X, Y, theta]
%   SF:
%   clr: contains robot color information
%
% =========================================================================
function plotEmptyRobot1(h,posn,SF)

x       = posn(1);
y       = posn(2);

rad1 = SF;

center = [x, y];
radius = rad1;
points = 100;
style = 'w';

THETA = linspace(0,2*pi,points);
RHO = ones(1,points)*radius;

[X,Y] = pol2cart(THETA,RHO);

X = X+center(1);
Y = Y+center(2);

fill(X,Y,style);
plot (X, Y, style, 'LineWidth', 2);