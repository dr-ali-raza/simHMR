function [xr,yr] = refCalc(trajectory)
global xc yc tS;
tol = 100;
loc = sqrt((xc-trajectory(tS,1)).^2+(yc-trajectory(tS,2)).^2);
if loc<tol
    xr = trajectory(tS+1,1);
    yr = trajectory(tS+1,2);
else
    tS = tS - 1;
    xr = trajectory(tS+1,1);
    yr = trajectory(tS+1,2);
end
% if size(trajectory,1)<2
%     xr = trajectory(1,1);
%     yr = trajectory(1,2);
% else
%     xr = trajectory(tS+1,1);
%     yr = trajectory(tS+1,2);
% end