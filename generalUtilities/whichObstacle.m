function y = whichObstacle(cPosn, obs, distO, th, thg)
%whichObstacle Summary of this function goes here
%   Detailed explanation goes here

tolerance = 10;
thDiff = th - thg;
[val, ind] = min(abs(thDiff));
d = distO(ind);

xObs = cPosn(1) + d*cos(th(ind));
yObs = cPosn(2) + d*sin(th(ind));

noObs = size(obs, 1);
yMat = zeros(1, noObs);
for i = 1:noObs
    obsLx = obs(i, 2);
    obsTy = obs(i, 3);
    obsRx = obs(i, 2) + obs(i, 4);
    obsBy = obs(i, 3) + obs(i, 5);
    
    if ((xObs>obsLx-tolerance)&&(xObs<obsRx+tolerance))
        if((yObs>obsTy-tolerance)&&(yObs<obsBy+tolerance))
            yMat(i) = i;
        end
    end
end

[y, n] = max(yMat);

end