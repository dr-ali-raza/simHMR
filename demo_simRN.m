% Demo Program for Mobile Robotics Simulations using Reactive Navigation
% Approach. It uses grayscale images for the selected arena
%
% Ali Raza, (c) 2018
% ali.raza@ymail.com
%
% AI & Robotics Lab
% University of Engineering and Technology, Lahore, Pakistan
% ========================================================================
% ========================================================================
clear; close all;
global sBinStr_l sensorOut tag1 positionTrace orientationTrace thT
addpath('plotUtilities','generalUtilities','arenaUtilities','sensorUtilities','navModules','scenarios')
% addpath(genpath(pwd))
set(0,'DefaultFigureWindowStyle','docked')
%set(0,'DefaultFigureWindowStyle','normal')

% ========================================================================
% Experiment configuration: either choose the following

rad         = 10;
SF          = 10;
tag1        = 0;
tag2        = 1;
negR        = 0;
thT         = 1;
colC        = 0;    % collision counter
numS        = 1;
tarPC       = 0;    % target persistence
fluC        = 0;    % fluctuation in trajectory
ID          = 1;
tS          = 1;
dt          = 1;

nR                  = 1;
nRmax               = 7;    % maximum number of robots (for specifying colors only)
maxEnergy           = 3000;
energy              = maxEnergy;
esLocX              = 150;            
esLocY              = 450;  % Energy Source location
positionTrace       = [];
collisionTrace      = [];
energyTrace         = [];
orientationTrace    = [];
inflammationTrace   = [];
idTrace             = [];
wallClr             = 6;

icPalette           = [50 50 pi/2; 
                    435 50 pi/2; 
                    800 50 pi/2; 
                    45 300 pi/2; 
                    800 300 pi/2; 
                    50 500 pi/2; 
                    400 550 pi/2; 
                    800 550 pi/2];
                
clrs                = [.2 .7 .2; .7 .4 .4; .2 .2 .6; .4 .4 .2; .6 .2 .4; .6 .4 .2; .4 .4 .4 ];
clrPalette          = [(1:nRmax)' clrs];
sDepPalette         = [250; 350; 250; 250; 250; 250; 250];
sSpanPalette        = [2*pi/3; 2*pi/2; 2*pi/3; 2*pi/3; 2*pi/3; 2*pi/3; 2*pi/3];
sBinStr_lPalette    = [16; 30; 20; 16; 30; 20; 25];
energyPalette       = [maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy];
idPalette           = [1; 1; 1; 1; 1; 1; 1];
incmpNames          = {'posn', 'clr', 'sDep', 'sSpan', 'sBinStr_l', 'energy'};
orienPalette        = icPalette(:,end);

% ========================================================================
% or execute the follwing file named: 'expConfig'
% load('expConfig')

% ========================================================================
tF = 250;
% ========================================================================
% Plotting configuration

recallArena = 1;

% The arena names to try are as follows:
% Simple Arenas: 'S0_1a', 'S0_1b', 'S0_1c', 
% Shaped Worlds: 'S1_1a', 'S1_1b', 'S1_1c', 'S1_1d', 'S1_1e','S1_1f', 
% Distributed Worlds 1: 'S2_2a', 'S2_2b', 'S2_2c', 'S2_2d', 'S2_2e', 
% Distributed Worlds 2: 'S2_3a', 'S2_3b', 'S2_3c', 'S2_3d', 'S2_3e',
% replace the following name one by one!

arenaName = 'S2_3c';
if recallArena == 1
    load(arenaName, 'arena', 'obstacles', 'targets')
    arenaSize = [arena(1,2) arena(1,3) arena(3,4) (arena(3,3)+arena(3,5))];
    [arena, obstacles, targets] = recreateArena(arenaSize, arena, obstacles, targets);
    [obstSr, obstSc] = size(obstacles);
    [targSr, targSc] = size(targets);
    nObst          = obstSr;
    nTarg          = targSr;
    MM             = nTarg;
end

% ========================================================================
% Plot of Scenario
[course, course1] = plotCourse(arenaName, wallClr);
h1 = imshow(course); axis image off; colormap gray;
hold on;
[ES] = energySource(esLocX,esLocY);

% ========================================================================
% Initial plots prior to start of robotic activity
for kk = 1:nR
    plotRobot1(h1, icPalette(kk,:), SF, clrPalette(kk,2:4));
    plotSensor(h1, icPalette(kk,:), rad, sDepPalette(kk), sSpanPalette(kk));
    [sensorOut] = sensorModule(icPalette(kk,:), rad, course, course1, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));
    if kk == 1; tag1 = 0; end
end
% pause

% ========================================================================

posn1       = icPalette(1,:);
posn        = posn1;
posn_p      = [posn(1)-2 posn(2)-2 posn(3)];

patchesT    = zeros(2*nTarg,200);
patchI      = 1;

jj          = 1;
ii          = 1;
nn          = 1;
ll          = 1;
tInd        = zeros(1,nTarg);
tagSearch   = 1;
tagRescue   = 0;
tSwitch     = [];
tag3        = 0;
tic
while((nTarg ~= 0) || (tagSearch ==1) || (tagRescue == 1)) && (tS <= tF)
    
    posn            = icPalette(ll,:);
    clr             = clrPalette(ll,2:4);
    sDep            = sDepPalette(ll);
    sSpan           = sSpanPalette(ll);
    sBinStr_l       = sBinStr_lPalette(ll);
    energy          = energyPalette(ll);
    ID              = idPalette(ll);
    orientation     = orienPalette(ll);
    positionTrace   = [positionTrace posn'];
    
    % =====================================================================
    % Sense-and-Act
    [sensorOut] = sensorModule(posn, rad, course, course1, sDep, sSpan, sBinStr_l);
    [objFn_H1_out] = objFn_Heading1(sensorOut, sBinStr_l, sDep);
    F_th1 = objFn_H1_out(1,:);
    [thC, thT] = max(F_th1);
    theta = (sensorOut(6,thT));
    
    % ========================================================================
    % Step Sizing
    stepSize = 7;
    stepRes = 5; % odd number
    [rho1] = varStep(stepSize,stepRes,thT,sensorOut,sDep);
    % For fixed step movement, uncomment the following
    % rho1 = stepSize;
    
    % =====================================================================
    % Energy Consumption
    [EE, negR, kappa] = energyFa(posn, sBinStr_l, sensorOut, sDep, energy, ES, negR, maxEnergy);
    
    % =====================================================================
    % Search and Rescue 
    if (tagSearch == 1)
        [prx, pry] = pol2cart(theta,rho1);
        posn_p = posn;
        posn = [posn(1)+prx posn(2)+pry theta];
        N_targP = nTarg;
        figure(1)
        plotRobot1(h1, posn, SF, clr)
        drawnow;
        
        for i =1:nTarg
            diffX = abs(posn(1)-(targets(i,2)+(targets(i,4)/2)));
            diffY = abs(posn(2)-(targets(i,3)+(targets(i,5)/2)));
            diffVal = 30;
            if (diffX < diffVal) && (diffY < diffVal)
                if tInd(i) == 0
                    tInd(i) = i;
                    tagRescue = 1;
                    tag3 = i;
                    tagSearch = 0;
                    ID = 3;
                end
            end
            
            if (diffX < diffVal) && (diffY < diffVal)
                tag2 = 0;
                tagRescue = 1;
                tagSearch = 0;
                % jj = jj+1
                cInfo1 = get(h1, 'CData');
                abc = floor(targets(tInd(i),2)-8:(targets(tInd(i),2)+targets(tInd(i),4)+8));
                bcd = floor((targets(tInd(i),3)-8):(targets(tInd(i),3)+targets(tInd(i),5)+8));
                cInfo1(bcd,abc) = 0;
                course(bcd,abc)=255;
                ID = 3;
            end
        end
    end
    if (tagRescue == 1)
        
        [prx, pry] = pol2cart(theta,rho1);
        posn_p = posn;
        posn = [posn(1)+prx posn(2)+pry theta];
        N_targP = nTarg;
        figure(1)
        plotRobot1(h1, posn, SF, clr)
        % drawnow;
        
        diffX = abs(posn(1)-(targets(tInd(tag3),2)+(targets(tInd(tag3),4)/2)));
        diffY = abs(posn(2)-(targets(tInd(tag3),3)+(targets(tInd(tag3),5)/2)));
        if (diffX < diffVal) && (diffY < diffVal)
            targets(tInd(tag3),1) = 0;
            cInfo = get(h1, 'CData');
            abc = floor(targets(tInd(tag3),2)-8:(targets(tInd(tag3),2)+targets(tInd(tag3),4)+8));
            bcd = floor((targets(tInd(tag3),3)-8):(targets(tInd(tag3),3)+targets(tInd(tag3),5)+8));
            cInfo(bcd,abc) = 200;
            set(h1, 'CData', cInfo);
            course(bcd,abc)=255;
            drawnow;
            targets(tInd(tag3),:) = [];
            nTarg = nTarg - 1;
            % tagRescue = 0;
            if any(tInd ~=0); tagRescue = 0; end
            if nTarg == 0; tagSearch = 0; else tagSearch = 1;end
            tInd(tag3) = [];
            patchesT(patchI,1:length(abc)) = abc;
            patchesT(patchI+1,1:length(bcd)) = bcd;
            patchI = patchI + 2;
            tSwitch(nn) = ii;
            nn = nn + 1;
            tagSearch = 1;
            tag3 = 0;
        end
    end
    % =====================================================================
    % Updating the traces
    orientation         = posn_p(3);
    collision           = kappa(1,thT);
    energy              = EE(1,thT);
    icPalette(ll,:)     = posn;
    energyPalette(ll)   = energy;
    idPalette(ll)       = ID;
    orienPalette(ll)    = orientation;
    tarPer              = tagRescue;
    
    orientationTrace    = [orientationTrace orientation];
    collisionTrace      = [collisionTrace collision];
    energyTrace         = [energyTrace energy];
    idTrace             = [idTrace ID];
    idPalette(ll)       = ID;
    
    tS = tS + 1;
    ii = ii + dt;
    if nTarg == 0; break; end
end
thyme = toc;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Results
TT = tF;
tt = ii;
mm = MM-nTarg;
HH = 1;                                 % simulation-start is the only human interaction
MS = 50*((mm/MM) + 1 - (tt/TT))/(HH*HH);% Mission success metric as in [RoboCup Rescue]
CC = nnz(collisionTrace);

Results = [thyme tt CC MS]';
Traces = [positionTrace' collisionTrace'  energyTrace' inflammationTrace' idTrace'];

p = profile('info');
name = arenaName;

path1 = pwd;
path2 = strcat(path1,'\results\');
fullName = strcat(path2,name);
save(fullName,'p','Results','Traces','tSwitch', 'patchesT');

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Additional Plots
figure(2);
hold on;
subplot(2,1,1),
plot(energyTrace(1:end),'g'),
axis([0 length(energyTrace) 0 max(energyTrace)+5]);
ylabel('Energy Trace')

subplot(2,1,2),
plot(collisionTrace(1:end),'g')
axis([0 length(collisionTrace) -0.5 1.5]);
ylabel('Collision Trace')
xlabel('Simulation Steps')

figure(3);
plot_objFn_H1(sensorOut, objFn_H1_out);
