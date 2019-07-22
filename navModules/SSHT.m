function heading = SSHT(cPosn, sDir, obsDist, sDep, stepSize, course, targets)
%steadyStateHeatTransferFn 

target = NearestGoal(cPosn, targets);
[potLines, maxVal]= formEquiPotentialLines(course, target);
obsMap = bitwiseMapArrenaforObstacles(course, maxVal);
heatGradient = potLines + obsMap;

[xLim, yLim] = size(heatGradient);


noDir = length(sDir);
potVal = zeros(1, noDir);

for i = 1:noDir
    xCor = cPosn(1) + stepSize*cos(sDir(i));
    xCor = round(xCor);
    if xCor>= xLim-sDep/2
        xCor = xLim - 10;
    end
    
    yCor = cPosn(2) + stepSize*sin(sDir(i));
    yCor = round(yCor);
    if yCor >= yLim-sDep/2
        yCor = yLim - 10;
    end
    
    potVal(i) = heatGradient(round(yCor), round(xCor));
    if (obsDist(i)<sDep || potVal(i) < 0)
        potVal(i) = 0;
    end
end

[m, n] = max(potVal);

%sDir = fliplr(sDir);
heading = sDir(n);

end
