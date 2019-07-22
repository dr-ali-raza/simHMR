% ========================================================================
function [arena] = createArena2(Arena_Size, arenaSelection,handles)
% =======================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creates the arena of desired specifications
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%name = arenaName;
selection = arenaSelection;
Arena_Size
% Arena-boundary is defined in terms of polygons
Ax = Arena_Size(1);
Ay = Arena_Size(2);
Aw = Arena_Size(3);
Ah = Arena_Size(4);
Abw = 10;    % arena border/wall width
arenaUI = [Ax,Ay,Aw,Abw; Aw-Abw,Ay+Abw,Abw,Ah-2*Abw; Ax,Ay+Ah-Abw,Aw,Abw;Ax,Ay+Abw,Abw,Ah-2*Abw];
arena = [(1:4)' arenaUI];

% ========================================================================
% Different Scenarios
switch selection
    case 'EW'
        % ========================================================================
        % E shaped scenario
        x = [450 200 200 450]';
        y = [500 500 100 100]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [200 400]';
        y = [300 300]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
    case 'HW'
        % ========================================================================
        % H shaped scenario
        x = [300 300]';
        y = [100 500]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [300 600]';
        y = [300 300]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [600 600]';
        y = [100 500]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
    case 'SW'
        % ========================================================================
        % S shaped scenario
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
        [x,y] = ginput(7);
        xy = [x';y'];
        % Interpolate with a spline curve and finer spacing.
        t = 1:7;
        ts = 1: 0.1: 7;
        xys = spline(t,xy,ts);
        line(xys(1,:),xys(2,:),'LineWidth',8,'Color',[0 0 0]);
        
    case 'UW'
        % ========================================================================
        % U shaped scenario
        x = [200 500]';
        y = [200 200]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [200 500]';
        y = [450 450]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        r = 125;
        ang = -pi/2:0.01:pi/2;
        xp = r*cos(ang);
        yp = r*sin(ang);
        line(500+xp,325+yp,'LineWidth',8,'Color',[0 0 0]);
        
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
    case 'WW'
        % ========================================================================
        % W shaped scenario
        x = [100 250]';
        y = [500 100]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [250 400]';
        y = [100 500]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [400 550]';
        y = [500 100]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [550 700]';
        y = [100 500]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
    case 'XW'
        % ========================================================================
        % X shaped scenario
        x = [200 600]';
        y = [100 500]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        x = [200 600]';
        y = [500 100]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
    case 'CAW'
        % ========================================================================
        % A combined scenario of previous alphabetic shapes
        Xoffset = -10;
        Yoffset = -25;
        x = Xoffset+[200 100 100 200 250 300 350 400 500]';
        y = Yoffset+[500 500 300 300 100 300 100 300 300]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        r = 50;
        ang = -pi/2:0.01:pi/2;
        xp = r*cos(ang);
        yp = r*sin(ang);
        line(Xoffset+500+xp,Yoffset+350+yp,'LineWidth',8,'Color',[0 0 0]);
        
        x = Xoffset+[500 400 550 775 775]';
        y = Yoffset+[400 400 550 550 450]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        x = Xoffset+[100 200]';
        y = Yoffset+[400 400]';
        line(x,y,'LineWidth',8,'Color',[0 0 0]);
        
        [x,y] = ginput(7);
        xy = [x';y'];
        % Interpolate with a spline curve and finer spacing.
        t = 1:7;
        ts = 1: 0.1: 7;
        xys = spline(t,xy,ts);
        line(xys(1,:),xys(2,:),'LineWidth',8,'Color',[0 0 0]);
        
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
    case 'SpW'
        % ========================================================================
        % Sparse obstacles and targets in arena
        tag_UDOnT = 1;          % tag for user defined obstacles and targets
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
    case 'MW'
        % ========================================================================
        % Maze world arena
        %
        nLinesX = 8;
        nLinesY = 6;
        sLinesX = Arena_Size(3)/nLinesX;
        sLinesY = Arena_Size(4)/nLinesY;
        X = (Arena_Size(3)/sLinesX);
        Y = (Arena_Size(4)/sLinesY);
        
        maze = genMaze(X,Y,sLinesX,sLinesY);
        
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');
        
end
% ========================================================================
% data output from arena function
grid off
name    ='S_g';
path1   = pwd;
path2   = strcat(path1,'\saved_figrs\');
fullName = strcat(path2,name);

Fig2    = figure;
copyobj(handles.Arena_axis, Fig2);
lado    = handles.arens;
Aw      = lado(3);
Ah      = lado(4);

grid off
% set(Fig2, 'Units', 'pixels', 'position', [0 0 Aw+1 Ah+1 ]);
set(Fig2, 'Units', 'pixels', 'position', [0 0 Aw-80 Ah-20 ]);
% set(Fig2, 'paperunits', 'points', 'papersize', [Aw+1 Ah+1]);
saveas(Fig2,fullName,'png');
save(fullName,'arena')
delete(Fig2);