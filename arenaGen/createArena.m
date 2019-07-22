% Arena function to draw different arenas
%
% Written by Ali Raza
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function [arena obstacles targets] = createArena(Arena_Size, N_Obst, N_targ, arenaName, arenaSelection)
% ========================================================================

if nargin < 1, Arena_Size       = [0,0,840,600]; end
if nargin < 2, N_Obst           = 6; end
if nargin < 3, N_targ           = 1; end
if nargin < 4, arenaName        = 'S2_3a'; end
if nargin < 5, arenaSelection   = 'SpW_UD'; end % e.g 'EW', 'HW', 'SW', 'UW', 'WW', 'XW', 'CAW', 'MW', 'SpW', 'SpW_UD'

% Uncomment the following for creating arena, outside the simulation loop
% Arena_Size       = [0,0,840,600]; 
% N_Obst           = 9; 
% N_targ           = 2; 
% arenaName        = 'S2_3cc'; 
% arenaSelection   = 'SpW_UD'; % e.g 'EW', 'HW', 'SW', 'UW', 'WW', 'XW', 'CAW', 'MW', 'SpW', 'SpW_UD'
% arenaSelection   = 'SpW'; % e.g 'EW', 'HW', 'SW', 'UW', 'WW', 'XW', 'CAW', 'MW', 'SpW', 'SpW_UD'

obstacles = [];
targets = [];
tag_UDOnT = 0;

name = arenaName;
selection = arenaSelection;

% Arena-boundary is defined in terms of polygons
Ax = Arena_Size(1);
Ay = Arena_Size(2);
Aw = Arena_Size(3);
Ah = Arena_Size(4);
Abw = 10;    % arena border/wall width
arenaUI = [Ax,Ay,Aw,Abw; Aw-Abw,Ay+Abw,Abw,Ah-2*Abw; Ax,Ay+Ah-Abw,Aw,Abw;Ax,Ay+Abw,Abw,Ah-2*Abw];
arena = [(1:4)' arenaUI];
% fig = figure('Visible', 'off');
fig = figure(1);
set(fig, 'Units', 'pixels', 'position', [100 100 Aw Ah] );
hold on;

% ========================================================================
grid on
% pause
% ========================================================================
% Different Scenarios (Choose one by uncommenting the required section)
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

    case 'SpW'
        % ========================================================================
        % Sparse obstacles and targets in arena
        tag_UDOnT = 1;          % tag for user defined obstacles and targets
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');

        % ========================================================================
        % for random generation of obstacles
        ox = zeros(1,N_Obst);
        oy = zeros(1,N_Obst);
        ow = zeros(1,N_Obst);
        oh = zeros(1,N_Obst);
        oID = zeros(1,N_Obst);
        for n = 1:1:N_Obst
            ow_min = 40;
            oh_min = 40;
            ow_max = 70;
            oh_max = 70;
            ox(n) = round(Ax + (Aw-ow_max)*rand(1));
            oy(n) = round(Ay + (Ah-oh_max)*rand(1));
            ow(n) = round(ow_min + (ow_max-ow_min)*rand(1));
            oh(n) = round(oh_min + (oh_max-oh_min)*rand(1));
            if n>1
                oxn = ox(n);
                oxn1 = ox(n-1);
                own1 = ow(n-1);
                while(oxn==oxn1+own1+5)
                    oxn = round(Ax + (Aw-ow_max)*rand(1));
                end
                ox(n) = oxn;
            end
            %     rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'LineWidth',2,'FaceColor','k');
            rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
            oID(n) = n;
        end

        % ========================================================================
        % for random generation of targets
        tx = zeros(1,N_targ);
        ty = zeros(1,N_targ);
        tw = zeros(1,N_targ);
        th = zeros(1,N_targ);
        tID = zeros(1,N_targ);
        for m = 1:1:N_targ
            tw_min = 30;
            th_min = 30;
            tw_max = 50;
            th_max = 50;
            tx(m) = round(Ax + (Aw-tw_max)*rand(1));
            ty(m) = round(Ay + (Ah-th_max)*rand(1));
            tw(m) = round(tw_min + (tw_max-tw_min)*rand(1));
            th(m) = round(th_min + (th_max-th_min)*rand(1));
            % rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r','EraseMode','xor');
            rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','none');
            tID(m) = m;
        end
    case 'SpW_UD'
        % ========================================================================
        % Sparse obstacles and targets in arena
        tag_UDOnT = 1;          % tag for user defined obstacles and targets
        rectangle('Position',arenaUI(1,:),'FaceColor','k');
        axis([Ax-3,Aw+3,Ay-2,Ah+2]);
        rectangle('Position',arenaUI(2,:),'FaceColor','k');
        rectangle('Position',arenaUI(3,:),'FaceColor','k');
        rectangle('Position',arenaUI(4,:),'FaceColor','k');

        % ========================================================================
        % for user defined obstacles
        ox = zeros(1,N_Obst);
        oy = zeros(1,N_Obst);
        ow = zeros(1,N_Obst);
        oh = zeros(1,N_Obst);
        oID = zeros(1,N_Obst);
        for n = 1:1:N_Obst
            ow_min = 40;
            oh_min = 40;
            ow_max = 70;
            oh_max = 70;
            [ox(n) oy(n)] = ginput(1);
            ow(n) = round(ow_min + (ow_max-ow_min)*rand(1));
            oh(n) = round(oh_min + (oh_max-oh_min)*rand(1));
            if n>1
                oxn = ox(n);
                oxn1 = ox(n-1);
                own1 = ow(n-1);
                while(oxn==oxn1+own1+5)
                    oxn = round(Ax + (Aw-ow_max)*rand(1));
                end
                ox(n) = oxn;
            end
            %     rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'LineWidth',2,'FaceColor','k');
            rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
            oID(n) = n;
        end

        % ========================================================================
        % for user defined targets
        tx = zeros(1,N_targ);
        ty = zeros(1,N_targ);
        tw = zeros(1,N_targ);
        th = zeros(1,N_targ);
        tID = zeros(1,N_targ);
        for m = 1:1:N_targ
            tw_min = 30;
            th_min = 30;
            tw_max = 50;
            th_max = 50;
            [tx(m) ty(m)] = ginput(1);
            tw(m) = round(tw_min + (tw_max-tw_min)*rand(1));
            th(m) = round(th_min + (th_max-th_min)*rand(1));
            % rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r','EraseMode','xor');
            rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','none');
            tID(m) = m;
        end
end

% ========================================================================
% for random generation of obstacles
if tag_UDOnT == 0
    ox = zeros(1,N_Obst);
    oy = zeros(1,N_Obst);
    ow = zeros(1,N_Obst);
    oh = zeros(1,N_Obst);
    oID = zeros(1,N_Obst);
    if N_Obst~=0
        for n = 1:1:N_Obst
            ow_min = 10;
            oh_min = 10;
            ow_max = 30;
            oh_max = 30;
            [ox(n) oy(n)] = ginput(1);
            ow(n) = round(ow_min + (ow_max-ow_min)*rand(1));
            oh(n) = round(oh_min + (oh_max-oh_min)*rand(1));
            if n>1
                oxn = ox(n);
                oxn1 = ox(n-1);
                own1 = ow(n-1);
                while(oxn==oxn1+own1+5)
                    oxn = round(Ax + (Aw-ow_max)*rand(1));
                end
                ox(n) = oxn;
            end
            % rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'LineWidth',2,'FaceColor','k');
            rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
            oID(n) = n;
        end
    end
    % ========================================================================
    % for random generation of targets

    tx = zeros(1,N_targ);
    ty = zeros(1,N_targ);
    tw = zeros(1,N_targ);
    th = zeros(1,N_targ);
    tID = zeros(1,N_targ);
    if N_targ~=0
        for m = 1:1:N_targ
            tw_min = 10;
            th_min = 10;
            tw_max = 30;
            th_max = 30;
            [tx(m) ty(m)] = ginput(1);
            tw(m) = round(tw_min + (tw_max-tw_min)*rand(1));
            th(m) = round(th_min + (th_max-th_min)*rand(1));
            % rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r','EraseMode','xor')
            rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','none');
            tID(m) = m;
        end
    end
end
% ========================================================================
% data output from arena function
grid off
obstacles = [oID', ox', oy', ow', oh'];
targets = [tID', tx', ty', tw', th'];

set(gca, 'Units', 'pixels', 'position', [0 0 Aw+1 Ah+1 ]);
set(fig, 'paperunits', 'points', 'papersize', [fix((Aw-1)*(3/4))+1 fix((Ah-1)*(3/4))+1]);
set(fig, 'paperunits', 'normalized', 'paperposition', [0 0 1 1]);

% fullName = strcat('C:\Users\Raza\Desktop\codeHMRS_idiotypic\scenarios\',name);
saveas(gcf,name,'png')
% saveas(gcf,fullName,'png')
% ========================================================================
% Comment the following lines if function is called from simulation file

% to save in current directory
save(name, 'arena', 'obstacles', 'targets'); 

% to save in specific directory
% save(fullName,'arena','obstacles', 'targets');
