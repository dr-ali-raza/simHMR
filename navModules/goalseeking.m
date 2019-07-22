function path = goalseeking(posn,goal)
global course;
wallClr = 20;
se=strel('disk',wallClr);
bw = imerode(~(bwareaopen(~im2bw(course,74/255),120)),se);
map = robotics.BinaryOccupancyGrid(flipud(~bw));
planner = robotics.PRM(map,100);
startLocation = [posn(1) posn(2)];
endLocation = [goal(1) goal(2)];
path = findpath(planner, startLocation, endLocation);
figure();
show(planner)