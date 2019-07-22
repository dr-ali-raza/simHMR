function [theta, rho1] = inversetranslateRobot(xr,yr)
global linVelo b xc yc pre_b phiV xR yR;
maxVelo = 15;
b = directionCalc(xc,yc,xr,yr);
xR = xr-xc;
yR = yr-yc;
 phiV = InverseTranslate(xR,yR);    %Kinematic Model
%phiV = DynTranslate();            %Dynamic Model
linVelo = phiV(1);
if linVelo > maxVelo
    linVelo = maxVelo;
end
pre_th = (pre_b-135)*pi/180;
theta = (b-135)*pi/180;%atan2(yR,xR);
rho1 = linVelo;
[t,y] = ode45(@diff_Translation,[0,1],[xc,yc,0]);
xc = y(end,1);
yc = y(end,2);