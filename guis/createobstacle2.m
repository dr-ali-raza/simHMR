function [arena obstacles] = createobstacle2(Arena_Size, N_Obst, tag,mov2,handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creates obstacles in the arena
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
addpath(genpath(path1));
arenaName = 'S_g';
course = rgb2gray(imread(arenaName,'png'));
hold on;
obstacles = [];
tag;    % user-defined=0;random=1
mov2;   % moving=1;staionary=2
% Arena_Size;
Ax = Arena_Size(1);
Ay = Arena_Size(2);
Aw = Arena_Size(3);
Ah = Arena_Size(4);
Abw = 10;    % arena border/wall width
arenaUI = [Ax,Ay,Aw,Abw; Aw-Abw,Ay+Abw,Abw,Ah-2*Abw; Ax,Ay+Ah-Abw,Aw,Abw;Ax,Ay+Abw,Abw,Ah-2*Abw];
arena = [(1:4)' arenaUI];
if tag==1 && mov2==2
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
        % rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'LineWidth',2,'FaceColor','k');
        rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
        oID(n) = n;
    end
elseif tag==1 && mov2==1
    delay= 0.1;
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
        for i=1:100
            ow(n) = round(ow_min + (ow_max-ow_min));
            oh(n) = round(oh_min + (oh_max-oh_min));
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
            h4 = rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
            q1=[ox(n),oy(n)];
            distel1=sensrs_ofm(q1,course);
            if ((distel1<20) && (distel1>=0))
                ox(n)= ox(n)-20;                              %decrease x-distance by 35
                oy(n)= oy(n)-15;
            else
                ox(n)=ox(n)+5;                              %decrease x-distance by 35
                oy(n)=oy(n);
            end
            pause(delay);
            % set(h1,'EraseMode','xor');
            delete(h4)
            oID(n) = n;
        end
        h4=rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
    end
elseif tag==2 && mov2==1
    delay=0.1;
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
        for i=1:100
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
            h5 = rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
            ox(n)=ox(n)+5;
            oy(n)=oy(n)+5;
            pause(delay);
            delete(h5)
            oID(n) = n;
        end
    end
elseif tag==2 && mov2==2
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
        % rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'LineWidth',2,'FaceColor','k');
        rectangle('Position',[ox(n),oy(n),ow(n),oh(n)],'FaceColor','k');
        oID(n) = n;
    end
end
obstacles = [oID', ox', oy', ow', oh'];
name = 'S_h';
fullName = strcat(path2,name);

Fig2 = figure;
copyobj(handles.Arena_axis, Fig2);
lado = handles.arens;
Aw = lado(3);
Ah = lado(4);

grid off
% set(Fig2, 'Units', 'pixels', 'position', [0 0 Aw+1 Ah+1 ]);
set(Fig2, 'Units', 'pixels', 'position', [0 0 Aw-80 Ah-20 ]);
% set(Fig2, 'paperunits', 'points', 'papersize', [Aw+1 Ah+1]);
saveas(Fig2,fullName,'png');
save(fullName,'arena','obstacles')
delete(Fig2);