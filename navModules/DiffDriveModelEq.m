function dot_f = DiffDriveModelEq(t, f)
%DiffDriveModelEq holds the differential equations for a Differential Drive
%Robot.
%   


global wheelV

x = f(1);
y = f(2);

theta = arctan(y/x);

dot_x = ((wheelV(1)+wheelV(2))/2) * cos(theta);
dot_y = ((wheelV(1)+wheelV(2))/2) * sin(theta);

dot_f = [dot_x, dot_y];
end