%function [heading] = CVM(robot, target, senOrien, obstacles, obsDist, senRange)
function [heading] = CVM(param, cPosn, obstacles, oDist, sDirs, gTarg, thetagoal)
% CVM is implementation of Curvature-Velocity Method Algorithm as proposed in
% "The Curvature-Velocity Method for Local Obstacle Avoidance" proposed by
% Reid Simmons
%
% University of Engineering and Technology, Lahore, Pakistan
%--------------------------------------------------------------------------
% Input Variable:
%   param -> containers contain different parameters related to CVM
%   algorithm
%   robot -> location of robot in arrena [x, y, dir]
%   target -> position of target in the arrena [x, y, xspan, yspan]
%   senOrien -> orientations of installed sensors 
%   obstacles -> location of obstacles in the arrena
%   obsDist -> distance of obstacles from each sensor
%   senRange -> range of distance sensors
% Output Variable:
%   heading -> contains value of direction (angle) heading towards goal
% =========================================================================

tv_max = param(1);
rv_max = param(2);
ta_max = param(3);
ra_max = param(4);

% unknown parameters
rv=10;%15
tv=10;%2
tv_max = 10;

% find obstacle center and radius
%obsNo = whichObstacle(cPosn, obstacles, oDist, sDirs, thetagoal);
obsX=obstacles(2)+(obstacles(4)/2);
obsY=obstacles(3)+(obstacles(5)/2);
obsR=sqrt((obstacles(2)-obsX).^2+(obstacles(3)-obsY).^2);

% find minimum and maximum carvatures and obstacle point co-ordinates
cmin=2*(obsX-obsY)/sqrt(obsX^2+obsY^2+obsR^2);
cmax=2*(obsX+obsY)/sqrt(obsX^2+obsY^2+obsR^2);
xmin=(obsX-obsR)/(1-(cmin*obsR));
ymin=obsY/(1-(cmin*obsR));
xmax=(obsX+obsY)/(1+(cmax*obsR));
ymax=obsY/(1+(cmax*obsR));

rmin = 1/cmin;
rmax = 1/cmax;

if cmin < 0
    thetamin = atan2(ymin,xmin-rmin);
else
    thetamin = pi-atan2(ymin,xmin-rmin);
end

if cmax < 0 
    thetamax = atan2(ymax,xmax-rmax);
else
    thetamax = pi-atan2(ymax,xmax-rmax);
end

if cmin==0
    dcmin=ymin;
else
    dcmin=abs(1/cmin)*thetamin;
end

if cmax==0
    dcmax=ymax;
else
    dcmax=abs(1/cmax)*thetamax;
end

if cmin<=rv || tv<=cmax
    dv=min(dcmin,dcmax);
else
    dv=inf;
end

speed=tv/tv_max;
c=[];
Tc=1;  L=15; a1=0.1; a2=1; a3=0.5;
dist=(dv)/L;
head=1-abs(thetagoal-rv*Tc)/pi;
f=a1*speed+a2*dist+a3*head;
[heading]= f;

end