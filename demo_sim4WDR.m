% Test Program for 4 wheel omni-directional mobile robot
% Using probabilistic road maps
%
% Ali Raza, ali.raza@ymail.com
% Rzi Abbas
%
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ========================================================================
% ========================================================================
clear; close all;
addpath('plotUtilities','generalUtilities','arenaUtilities','sensorUtilities','navModules','scenarios')
%set(0,'DefaultFigureWindowStyle','docked')
set(0,'DefaultFigureWindowStyle','normal')

% ========================================================================
% First execute the file named: 'expConfig'
load('expConfig')
global tS SF;
tS  = 1;
tF  = 500;
SF = 10;
clr = [.2 .4 .4];
% ========================================================================
% Plotting configuration

recallArena = 1;
% 'S0_0c' is the empty arena
arenaName = 'S2_2e';%'S0_0c';%'S1_1b'; %'S1_1b';
% ========================================================================
% Initial plots
global course;
course = rgb2gray(imread(arenaName,'png'));
course = flipud(course);
course = imresize(course, [600 840]);
h1 = imshow(course); axis image off; colormap gray;
hold on;

% ========================================================================
% traj = trajectory('p',400,400,tF);   %Trajectory Generation
% traj = trajectory('l',40,200,780,200,tF);
% traj = trajectory('pp',20,200,820,200,tF);
% traj = trajectory('c',350,300,250,tF);
% fill(traj(:,1),traj(:,2),'r');              %Trajectory Drawing

 posn = ginput(1); % [100 100 0];
% posn = [100 300 0];
% posn = [100 500 0];
% posn = [420 500 0];
% posn = [740 500 0];
% posn = [740 300 0];
% posn = [740 100 0];
% posn = [420 100 0];
goal = goalfinder(posn);
goal_int = goalseeking(posn,goal(1,:));
tic

% Initiation of some additional parameters
global xc yc thc pre_b phiV dir;   %linVelo = Linear Velocity in Robot Frame, b = steering angle
xc = posn(1);       %xc = current position in x-direction
yc = posn(2);       %yc = current position in y-direction
thc = 0;            %thc = current orientation of the robot
finalAngle = 90;    %finalAngle = Required orientation of the robot at the target location (0-360 deg.)
rot_var = 0;
pre_b  = 135;
phiV = 0;
N = 1111;
span = 50;
dep = 40;
res = 0.5;
dir =2;
i = 1;
j = 1;
goal_int_temp  = 10;

while(1)
    % Your code here!
    % Portion for goal seeking
    traj = trajectory('p',goal_int(i,1),goal_int(i,2),tF);
    [xr,yr] = refCalc(traj);
    goal_temp = sqrt((xc-xr).^2+(yc-yr).^2);
    
    if goal_temp < 0.1
        i = i+1;
%         if i > length(goal_int)
%             break;
%         end
    end 
    goal_int_temp = sqrt((xc-goal(j,1)).^2+(yc-goal(j,2)).^2);
    if goal_int_temp < 0.1
        j = j+1;
        if j>size(goal,1)
            break;
        end
        i = 1;
        goal_int = goalseeking(goal(j-1,:),goal(j,:));
    end
    
    
    [theta,rho1] = inversetranslateRobot(xr,yr);
    [prx, pry] = pol2cart(theta,rho1);
    posn_p = posn;
    posn = [posn(1)+prx posn(2)+pry theta];
    figure(1)
    plotRobot2(h1, posn, SF, clr)
    drawnow;
    
    tS = tS + 1;
    
end
[prx, pry] = pol2cart(theta,rho1);
    posn_p = posn;
    posn = [posn(1)+prx posn(2)+pry theta];
   figure(1)
   plotRobot2(h1, posn, SF, clr)
   drawnow;
    
thyme = toc;

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Results
Results = [thyme];
p = profile('info');
name = arenaName;

path1 = pwd;
path2 = strcat(path1,'\results\');
fullName = strcat(path2,name);
save(fullName,'p','Results');
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Plotting
