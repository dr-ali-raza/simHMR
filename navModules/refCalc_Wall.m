function [xr,yr] = refCalc_Wall(D1,D2,D3,D4)
global xc yc dir;
xr = xc;
yr = yc;
step = 10;
%tol = 100;
%loc = sqrt((xc-trajectory(tS,1)).^2+(yc-trajectory(tS,2)).^2);
if D2 ~= 0 && dir == 2
    xr = xc + step;
    yr = yc;
elseif D1 ~= 0 && dir == 1
    xr = xc;
    yr = yc + step;
elseif D4 ~= 0 && dir == 4
    xr = xc - step;
    yr = yc;
elseif D3 ~= 0 && dir == 3
    xr = xc;
    yr = yc - step;
end
if D3 == 0
    dir = 2;
    if D2 == 0;
        dir = 1;
    end
elseif D2 == 0
    dir = 1;
    if D1 == 0
        dir = 4;
    end
elseif D1 == 0
    dir = 4;
    if D4 == 0
        dir = 3;
    end
elseif D4 == 0
    dir = 3;
end
% elseif D1 == 1 && D2 == 1 && D3 == 1 && D4 == 1
%     tS = tS - 1;
%     xr = trajectory(tS+1,1);
%     yr = trajectory(tS+1,2);
% if size(trajectory,1)<2
%     xr = trajectory(1,1);
%     yr = trajectory(1,2);
% else
%     xr = trajectory(tS+1,1);
%     yr = trajectory(tS+1,2);
% end