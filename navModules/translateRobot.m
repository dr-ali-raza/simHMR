function [theta, rho1] = translateRobot(xr,yr)
global linVelo b xc yc;
gain = 0.6;
maxVelo = 50;
b = directionCalc(xc,yc,xr,yr);
linVelo = gain.*sqrt((xc-xr).^2+(yc-yr).^2);
if linVelo > maxVelo
    linVelo = maxVelo;
end
[t,y] = ode45(@diff_Translation,[0,1],[xc,yc,0]);
theta = atan2((y(end,2)-yc),y(end,1)-xc);
rho1 = linVelo;
xc = y(end,1);
yc = y(end,2);