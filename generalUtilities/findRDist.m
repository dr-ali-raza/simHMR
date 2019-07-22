function dist = findRDist(rPos, gPos)
%findRDist finds the distance between robot and goal center
%   

rx = rPos(1);
ry = rPos(2);
gx = gPos(1) + gPos(3)/2;
gy = gPos(2) + gPos(4)/2;

dist = sqrt((gx-rx)^2+(gy-ry)^2);

end