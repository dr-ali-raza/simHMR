function dist = findDist(rPos1, rPos2)
%findRDist finds the distance between two robot positions
%   

rx1 = rPos1(1);
ry1 = rPos1(2);
rx2 = rPos2(1);
ry2 = rPos2(2);

dist = sqrt((rx2-rx1)^2+(ry2-ry1)^2);

end