% Function to plot robot in the arena with axes
% 
% Written by Ali Raza, (c) 2013
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function plotRobot2(h,posn,SF,clr)

xb       = posn(1);
yb       = posn(2);
theta   = posn(3);
P       = pose2stance(xb,yb,theta,SF);

hold on

% robot platform
len1 = SF*0.7;
len2 = SF*0.3;
rectdatab = [xb-len1, yb-len1; xb-len1, yb+len1; xb+len1, yb+len1; xb+len1, yb-len1];

xs = xb;
ys = yb - len2;
% R = [cosd(theta) sind(theta); -sind(theta) cosd(theta)]';
% centers = R*[xs;ys];
% xs = centers(1);
% ys = centers(2);
rectdatas = [xs-len2, ys-len2; xs-len2, ys+len2; xs+len2, ys+len2; xs+len2, ys-len2];
fill(rectdatab(:,1),rectdatab(:,2),clr);
fill(rectdatas(:,1),rectdatas(:,2),'g');

% X2 = P(5:8,1);
% X2(5) = P(5,1);
% Y2 = P(5:8,2);
% Y2(5) = P(5,2);
% fill(X2,Y2,'-k');

% X3 = P(9:12,1);
% X3(5) = P(9,1);
% Y3 = P(9:12,2);
% Y3(5) = P(9,2);
% fill(X3,Y3,'-k');

%axes
axesLength = SF*1.3;
p = rotate(axesLength,0,theta) + [xb yb];
plot([xb p(1)], [yb p(2)], '-b');

%arrow in x-axis
p1 = rotate(axesLength,0,theta) + [xb yb];
p2 = rotate(SF*(1.3-0.2),SF*0.1,theta) + [xb yb];
plot([p1(1) p2(1)], [p1(2) p2(2)], '-b');

p1 = rotate(axesLength,0,theta) + [xb yb];
p2 = rotate(SF*(1.3-0.2),-0.1*SF,theta) + [xb yb];
plot([p1(1) p2(1)], [p1(2) p2(2)], '-b');