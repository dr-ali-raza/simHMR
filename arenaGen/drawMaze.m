% Function to draw maze world
%
% Written by Ali Raza
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function drawMaze(maze,sLinesX,sLinesY)

hold off;
clf;
hold on;

rows = maze.R;
cols = maze.C;
axis equal

index = 1;
for i = 1:cols
    for j = 1:rows
        % North
        HN = plot(sLinesX*[(i-1) (i)],sLinesY*[(rows-j+1) (rows-j+1)]);
        if(maze.conn(index,1) == 1)
            set(HN,'Color',[1 1 1],'LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
            %             set(HN,'Color',[1 1 1],'LineWidth',8);
        else
            set(HN,'Color',[0 0 0]);
            %             set(HN,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',2);
            set(HN,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
        end
        % South
        HS = plot(sLinesX*[(i-1) (i)],sLinesY*[(rows-j) (rows-j)]);
        if(maze.conn(index,3) == 1)
            set(HS,'Color',[1 1 1],'LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
            %             set(HS,'Color',[1 1 1],'LineWidth',8);
        else
            set(HS,'Color',[0 0 0]);
            %             set(HS,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',2);
            set(HS,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
        end
        % East
        HE = plot(sLinesX*[(i) (i)],sLinesY*[(rows-j+1) (rows-j)]);
        if(maze.conn(index,2) == 1)
            set(HE,'Color',[1 1 1],'LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
            %             set(HE,'Color',[1 1 1],'LineWidth',8);
        else
            set(HE,'Color',[0 0 0]);
            %             set(HE,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',2);
            set(HE,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
        end
        % West
        HW = plot(sLinesX*[(i-1) (i-1)],sLinesY*[(rows-j+1) (rows-j)]);
        if(maze.conn(index,4) == 1)
            set(HW,'Color',[1 1 1],'LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
            %             set(HW,'Color',[1 1 1],'LineWidth',8);
        else
            set(HW,'Color',[0 0 0]);
            %             set(HW,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',2);
            set(HW,'LineStyle','-','LineWidth',8,'Marker','s','MarkerSize',1.5,'MarkerFaceColor','k','MarkerEdgeColor','k');
        end
        index = index + 1;
    end
end
set(gca,'xtick',[],'ytick',[]);
hold off;