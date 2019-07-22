% Function to generate maze world 
% 
% Written by Ali Raza
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function maze = genMaze(X,Y,sLinesX,sLinesY)
maze = emptyMaze(X,Y);
groups = 1:(X*Y);
while(max(groups) > 1)
   gMax = max(groups);
    gInd = floor(rand(1,1) * gMax) + 1;
    gSel = find(groups == gInd);
    cellInd = floor(rand(1,1) * length(gSel)) + 1;
    cell = gSel(cellInd);
    cellX = ceil(cell / Y);
    cellY = mod(cell, Y);
    if(cellY == 0)
       cellY = Y;
    end
    % pick a random direction to merge walls
    Orien = floor(rand(1,1) * 4.0) + 1;
    cellNb = 0; % cell neighborhood
    switch floor(Orien)
        case 1
            cellNb = cell - 1;
            nY = cellY - 1;
            nX = cellX;
        case 2
            cellNb = cell + Y;
            nY = cellY;
            nX = cellX + 1;
        case 3
            cellNb = cell + 1;
            nY = cellY + 1;
            nX = cellX;
        case 4
            cellNb = cell - Y;
            nY = cellY;
            nX = cellX - 1;
         end
    neigh_set = gInd;
    if((nX <= X) & (nX > 0) & (nY <= Y) & (nY > 0))
       neigh_set = groups(cellNb);
    end
    if(neigh_set ~= gInd) % to merge groups
       inds = find(groups == neigh_set);
       groups(inds) = gInd * ones(1,length(inds));
       inds = find(groups >= neigh_set);
       groups(inds) = groups(inds) - 1;
        switch floor(Orien) % to open wall segments
            case 1
                maze.conn(cell,1) = 1;
                maze.conn(cellNb,3) = 1;
            case 2
                maze.conn(cell,2) = 1;
                maze.conn(cellNb,4) = 1;
            case 3
                maze.conn(cell,3) = 1;
                maze.conn(cellNb,1) = 1;
            case 4
                maze.conn(cell,4) = 1;
                maze.conn(cellNb,2) = 1;
             end
             drawMaze(maze,sLinesX,sLinesY);
             pause(0.1);
    end
end
drawMaze(maze,sLinesX,sLinesY);