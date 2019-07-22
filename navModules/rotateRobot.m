function [theta, rho1, stopFlag] = rotateRobot(angle)
global linVelo thc;
stopFlag = 0;
maxVelo = 0.5;
%phiV = DynTranslate();
%linVelo = phiV(1);
linVelo = abs(angle/180*pi-thc).*180/pi/45; %0.1;
if linVelo > maxVelo
    linVelo = maxVelo;
end
[t,y] = ode45(@diff_Rotate,[0,1],[0,0,thc]);
thc = wrapTo2Pi(y(end,3));
tol = abs(angle/180*pi-thc);
if tol<0.1
    stopFlag = 1;
end
theta = thc;
rho1 = 0;
