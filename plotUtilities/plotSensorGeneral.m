% Function to plot robot's sensor range
% 
% University of Engineering and Technology, Lahore
% ========================================================================
function plotSensorGeneral(h, posn, rad, C_dep, C_span, color)

mag1 = C_dep + rad;
p = rotate(mag1,0,(posn(3)- C_span/2)) + [posn(1) posn(2)];
plot([posn(1) p(1)], [posn(2) p(2)], 'Color', color);
p = rotate(mag1,0,(posn(3)- C_span/2 + C_span)) + [posn(1) posn(2)];
plot([posn(1) p(1)], [posn(2) p(2)], 'Color', color);
arc1([posn(1), posn(2)],posn(3),mag1,C_span,100, color);