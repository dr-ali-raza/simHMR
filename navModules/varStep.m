% Written by Ali Raza, (c) 2018
% ali.raza@ymail.com
%
% University of Engineering and Technology, Lahore
% ========================================================================
function [rho1] = varStep(stepSize,incr1_max,thT,sensorOut,sDep)
dist_acc = 0;
for incr1 = 1:1:(incr1_max-1)/2
    if (thT == length(sensorOut(1,:)))||(thT == length(sensorOut(1,:))-incr1+1)
        dist_oo(incr1) = sensorOut(3,thT);
    else
        dist_oo(incr1) = sensorOut(3,thT+incr1);
    end
end
dist_acc = sum(dist_oo);
for incr1 = (incr1_max-1)/2:-1:1
    if thT == 1
        dist_oo(incr1) = sensorOut(3,thT);
    elseif((thT-incr1)==0)
        dist_oo(incr1) = sensorOut(3,thT);
    else
        dist_oo(incr1) = sensorOut(3,thT-incr1);
    end
end
dist_acc = dist_acc + sum(dist_oo);
rho1 = stepSize*((sensorOut(3,thT) + dist_acc)/(incr1_max*sDep));
