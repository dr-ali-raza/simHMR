function b = directionCalc(xc,yc,xr,yr)
global pre_b;
gain  = 1;
x = xr-xc;
y = yr-yc;

Rot = [cosd(-90) -sind(-90); sind(-90) cosd(-90)];
%th = Rot*[x;y];
th = [x;y];
b = wrapTo360((atan2(th(2),th(1))+3*pi/4)/pi*180);

err_b = b-pre_b;
% if err_b > 100
%     err_b = 100*err_b/abs(err_b);
% end
b = wrapTo360(gain*err_b+pre_b);
pre_b = b;