function [arena targets] = createtarget2(Arena_Size, N_targ, tag,mov,handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creates targets in the selected arena
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
addpath(genpath(path1));
arenaName = 'S_h';
load(arenaName,'obstacles')
course = rgb2gray(imread(arenaName,'png'));
hold on;
targets = [];
tag; % user-defined=1;random=2
mov; % moving=1;staionary=2
% Arena_Size
Ax = Arena_Size(1);
Ay = Arena_Size(2);
Aw = Arena_Size(3);
Ah = Arena_Size(4);
Abw = 10;    % arena border/wall width
arenaUI = [Ax,Ay,Aw,Abw; Aw-Abw,Ay+Abw,Abw,Ah-2*Abw; Ax,Ay+Ah-Abw,Aw,Abw;Ax,Ay+Abw,Abw,Ah-2*Abw];
arena = [(1:4)' arenaUI];
if tag==1 && mov==2
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
        rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r');
        tID(m) = m;
    end
    
elseif tag==1 && mov==1
    
    delay= 0.1;                        %%%%%%%%%%%%%%%%%%%%%of cartesian coordinates of a straight line
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
        for i=1:100
            %  hold off;
            tw(m) = round(tw_min + (tw_max-tw_min));
            th(m) = round(th_min + (th_max-th_min));
            % rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r','EraseMode','xor');
            h1=  rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r');
            q=[tx(m),ty(m)];
            distel=sensrs_ofm(q,course);
            
            if ((distel<20) && (distel>=0))
                tx(m)= tx(m)-20;                              %decrease x-distance by 35
                ty(m)= ty(m)-15;
            else
                tx(m)=tx(m)+5;                              %decrease x-distance by 35
                ty(m)=ty(m);
            end
            pause(delay);
            % set(h1,'EraseMode','xor');
            delete(h1)
            %rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','g');
            tID(m) = m;
        end
        h1=  rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r');
    end
    
elseif tag==2  && mov==1
    % for random generation of targets
    delay= 0.1;
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
        for i=1:100
            tw(m) = round(tw_min + (tw_max-tw_min));
            th(m) = round(th_min + (th_max-th_min));
            % rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r','EraseMode','xor');
            h2=rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r');
            q=[tx(m),ty(m)];
            distel=sensrs_ofm(q,course);
            
            if ((distel<20) && (distel>=0))
                %clear all;
                tx(m)= tx(m)-20;                              %decrease x-distance by 35
                ty(m)= ty(m)-15;
            else
                tx(m)=tx(m)+5;                              %decrease x-distance by 35
                ty(m)=ty(m);
            end
            pause(delay);
            delete(h2)
            tID(m) = m;
        end
        h2=  rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r');
    end
    
elseif tag==2  && mov==2
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
        rectangle('Position',[tx(m),ty(m),tw(m),th(m)],'Curvature',[1,1],'FaceColor','r','EdgeColor','r');
        tID(m) = m;
    end
end
targets = [tID', tx', ty', tw', th']