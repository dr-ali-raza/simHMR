% Test Program for Mobile Robot Navigations Using grayscale image for arena
% in sensor module
%
% Written by: Ali Raza, ali.raza@ymail.com
% Modified by: Shujat Ali, mshujatali@gmail.com
%
% Research Title: "An Immunity-based Dynamic Reconfiguration of Mobile
% Robots in Un-structured Environment."
%
% Department of Mechatronics and Control Engineering, UET Lahore
% =========================================================================
clear; close all;
global sBinStr_l sBinStr_o sBinStr_t th th_g tag1 positionTrace orientationTrace thT 
addpath('plotUtilities','generalUtilities','arenaUtilities','sensorUtilities','navModules','scenarios', 'Improvements', 'navUtilities');
addpath(genpath('AIS'));  % add folder 'Libraries' and all its sub-folders to the path
set(0,'DefaultFigureWindowStyle','docked')
%set(0,'DefaultFigureWindowStyle','normal')

% ========================================================================
% Experiment configuration: either choose the following

ic1         = [50 50 0];     % POINT 1
% ic1         = [790 50 0];    % POINT 2
% ic1         = [50 550 0];    % POINT 3
% ic1         = [790 550 0];   % POINT 4

ic2         = [400 50 pi/2];
ic3         = [800 50 pi/2];
ic4         = [50 300 pi/2];
ic5         = [800 300 pi/2];
ic6         = [50 500 pi/2];
ic7         = [400 550 0];
ic8         = [800 550 pi];

rad         = 10;           % Radius of robot
SF          = 10;

tag1        = 0;
tag2        = 1;
esLocX      = 150;            % Energy Source location X
esLocY      = 450;            % Energy Source location Y
maxEnergy   = 3000;
energy      = maxEnergy;
negR        = 0;
thT         = 1;

colC        = 0;    % collision counter
numS        = 1;
tarPC       = 0;    % target persistence
fluC        = 0;    % fluctuation in trajectory
ID          = 1;
tS          = 1;
dt          = 1;
curTar      = zeros(1, 5); % current goal parameters

positionTrace       = [];
collisionTrace      = [];
energyTrace         = [];
orientationTrace    = [];
inflammationTrace   = [];
idTrace             = [];

nR                  = 1;    % number of robot(s) in arena
nRmax               = 7;    % maximum number of robots (for specifying colors only)
icPalette           = [ic1; ic2; ic3; ic4; ic5; ic6; ic7; ic8];
clrs                = [.2 .4 .4; .6 .4 .4; .2 .2 .4; .4 .4 .2; .6 .2 .4; .6 .4 .2; .4 .4 .4 ];
clrPalette          = [(1:nRmax)' clrs];    % color of each robot
sDepPalette         = [75; 350; 250; 250; 250; 250; 250];  % depth of sensors
sSpanPalette        = [2*pi; 2*pi/2; 2*pi/3; 2*pi/3; 2*pi/3; 2*pi/3; 2*pi/3]; %span of sensors
sBinStr_lPalette    = [18; 30; 20; 16; 30; 20; 25]; % number of sensors
energyPalette       = [maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy];    % energy of each robot
idPalette           = [1; 1; 1; 1; 1; 1; 1];
incmpNames          = {'posn', 'clr', 'sDep', 'sSpan', 'sBinStr_l', 'energy'};
orienPalette        = icPalette(:,end);
%==========================================================================
%--------------------------CVM's Paramters---------------------------------
CVM_param = [
 10;    % = tv_max (maximum translational velocity)
 10;    % = rv_max (maximum rotational velocity)
 5;     % = ta_max (maximum translational acceleration)
 5;     % = ra_max (maximum rotational acceleration)
 ];
%--------------------------RIN's Paramters---------------------------------
RIN_param = 48; %sBinStr_lPalette(1);    % = sensorSpan (span of sensors)

% ========================================================================
% or execute the follwing file named: 'expConfig'
% load('expConfig')

% ========================================================================
tF = 250;
% ========================================================================
% Plotting configuration

recallArena = 1;

% the arena names to try are as follows:
% 'S0_1a', 'S0_1b', 'S0_1c', 'S2_2a', 'S2_2b', 'S2_2c', 'S2_2d', 'S2_2e', 
% 'S2_3a', 'S2_3b', 'S2_3c', 'S2_3d', 'S2_3e'
% replace the following name one by one!

% arenaName = 'S2_3e';
arenaName = 'S2_3e';
title(cat(2,'Scenario = ',arenaName),'FontWeight','bold','FontSize',16);
if recallArena == 1
% load variables ('arena', 'obstacles', 'targets') of arenaName.mat file in
% current workspace (arena variable contains the information of arena boundary 
% walls parameters in clockwise fashion with top wall as first)
    load(arenaName, 'arena', 'obstacles', 'targets') 
% arenaSize contains the size of arena [0, 0, 840, 600]
    arenaSize = [arena(1,2) arena(1,3) arena(3,4) (arena(3,3)+arena(3,5))];
    [arena, obstacles, targets] = recreateArena(arenaSize, arena, obstacles, targets);
    [obstSr, obstSc] = size(obstacles);
    [targSr, targSc] = size(targets);
    nObst          = obstSr; % no. of obstacles
    nTarg          = targSr; % no. of targets
    MM             = nTarg;
end

% ========================================================================
% Initial plots
wallClr = 6;
[course, course1] = plotCourse(arenaName, wallClr);
h1 = imshow(course); axis image off; colormap gray;
hold on;

[ES] = energySource(esLocX,esLocY); % generate a mesh of energy source 

% ========================================================================

% Initial plots prior to start of algorithm
for kk = 1:nR
    plotRobot1(h1, icPalette(kk,:), SF, clrPalette(kk,2:4));
    plotSensor(h1, icPalette(kk,:), rad, sDepPalette(kk), sSpanPalette(kk));
    [sBinStr_o, sBinStr_t, dist_o, dist_t, dist_o1, th, th_o, th_g]  = sensorModule2a(icPalette(kk,:), rad, course, course1, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));
%     [sBinStr_o, sBinStr_t, dist_o, dist_t, dist_o1, th, th_o, th_g]   = sensorModule1c(icPalette(kk,:), rad, course, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));
    if kk == 1; tag1 = 0; end
end
% pause


% ========================================================================

posn1       = icPalette(1,:);
posn        = posn1;
posn_p      = [posn(1)-2 posn(2)-2 posn(3)];

patchesT    = zeros(2*nTarg, 200);
patchI      = 1;

jj          = 1;
ii          = 1;
nn          = 1;
ll          = 1;
% tInd        = 0;
tInd        = zeros(1, nTarg);
tagSearch   = 1;
tagRescue   = 0;
tSwitch     = [];
tag3        = 0;
tic

% parameters for final plotting
plotPosn = posn;
plotSDep = sDepPalette(1);
plotSpan = sSpanPalette(1);
plotNoOfSensors = sBinStr_lPalette(1);

%--------------------------------------------------------------------------
% Initialize Clonal Selection Algorithm (Generate random Antibodies)
noAB = 20; % no of antibodies
antiBodies = CSAantiBodiesGenerate(noAB);
affinityAB = zeros(noAB, 1);
headingAB = zeros(noAB, 1);
tarVar = 0;
m_p = 1;
     
curTar = nearestTarget(posn, targets);
gTh = goalDirection(posn, curTar);
rho1 = 6;
loop_count = 0; % counter for loop iteration count for AIS section
loop_val = 0;

sDep_plot = sDepPalette(1); % required for plotting sensor depth
sSpan_plot = sSpanPalette(1); % required for plotting sensor span

AIS_SenseTrace = []; % trace of number of sensors, depth and span
AIS_ContTrace = []; % trace of control algorithm used
AIS_ABBSTrace = []; % trace of antibody bitstring
AIS_InflTrace = zeros(1, tF); % trace of antibody inflamation
infVal = 0;
infThreshold = 0.7; % threshold of of inflamation
infSteps = 5; % number of steps after which new generation of anti-bodies will be generated due to high inflamation value

AIS_Trace = [];

while((nTarg ~= 0) || (tagSearch == 1) || (tagRescue == 1)) && (tS <= tF)

    posn            = icPalette(ll,:);      % current position of robot
    clr             = clrPalette(ll, 2:4);  % color of robot
    sDep            = sDepPalette(ll);      % depth of sensors
    sSpan           = sSpanPalette(ll);     % span of sensors
    sBinStr_l       = sBinStr_lPalette(ll); % number of sensors
    energy          = energyPalette(ll);    % energy possesed by robot
    ID              = idPalette(ll);        
    orientation     = orienPalette(ll);     % robot's heading direction
    positionTrace   = [positionTrace posn'];

    
    % Determine nearest target from 'targets' to robot and set it as
    % current target
    [sBinStr_o, sBinStr_t, dist_o, dist_t, dist_o1, th, th_o, th_g]  = sensorModule2a(icPalette(kk,:), rad, course, course1, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));        
%     [sBinStr_o, sBinStr_t, dist_o, th, th_g, dist_t] = sensorModule1(posn, rad, course, sDep, sSpan, sBinStr_l);


% ========================================================================
% Step Sizing
    sensorOut = [sBinStr_o; sBinStr_t; dist_o; dist_t; dist_o1; th; th_o; th_g];
    stepSize = 6;
    stepRes = 5; % odd number
    [rho1] = varStep(stepSize,stepRes,thT,sensorOut,sDep);
    % For fixed step movement, uncomment the following
    % rho1 = stepSize;

% End Step Sizing
% ========================================================================

    % Is plan algorithm required?
    curTar = nearestTarget(posn, targets);
    gTh = goalDirection(posn, curTar);
    [flag, dir] =  isObstacleInGoalDirection(gTh, th, dist_o, sDep);
    
    sDep_plot = sDep;
    sSpan_plot = sSpan;
    
    if(flag == false)
        theta = dir;
        % Store AIS parameters for final ploting
        spanInDegree = sSpan*180/pi;
        AIS_SenseTrace = [AIS_SenseTrace; sBinStr_l, sDep, spanInDegree];
        AIS_ContTrace = [AIS_ContTrace; 'nil'];
        AIS_ABBSTrace = [AIS_ABBSTrace; 'nill                            ']; %0000000000000000000000000000'];
        title(strcat('Number of sensors = ',num2str(sBinStr_l), '; Depth of sensing = ', num2str(sDep),...
            '; Span of sensors = ', num2str(spanInDegree)), 'FontSize', 14);
        xlabel('Navigation : Reactive', 'FontSize', 14);
        infVal = 0;
    else
        % Affinity Evaluation (expose all antibodies to given antigen)
        for ij = 1:noAB
            % Decode antibody 
            [noOfSensors, rangeOfSensors, spanOfSensors, robotWheels, robotControl, robotPlan] = abbs2spac(antiBodies(ij, :));
            % Update Robot's sensors count, range and span
            spanOfSensors = spanOfSensors*2*pi/360;
            %[sBinStr_o, sBinStr_t, dist_o, dist_t, dist_o1, th, th_o, th_g] = sensorModule1c(posn, rad, course, rangeOfSensors, spanOfSensors, noOfSensors);
%             [sBinStr_o, sBinStr_t, dist_o, th, th_g, dist_t] = sensorModule1(posn, rad, course, rangeOfSensors, spanOfSensors, noOfSensors);
            [sBinStr_o, sBinStr_t, dist_o, dist_t, dist_o1, th, th_o, th_g]  = sensorModule2a(posn, rad, course, course1, rangeOfSensors, spanOfSensors, noOfSensors);
            % Calculate affinity value
            [affinityAB(ij), headingAB(ij)] = AffinityEvaluation(antiBodies(ij, :), posn, curTar, dist_o, obstacles, course, rho1, th, CVM_param);
        end

        % Antibody Selection (with highest affinity with antigen)
        % -----------------------------------------------------------------
        [maxAffABval, maxAffABind] = max(affinityAB);
        maxAffAB = antiBodies(maxAffABind, :);
        [noOfSensors, rangeOfSensors, spanOfSensors, robotWheels, robotControl, robotPlan] = abbs2spac(maxAffAB);
        spanOfSensors = spanOfSensors*2*pi/360;
%         [sBinStr_o, sBinStr_t, dist_o, th, th_g, dist_t] = sensorModule1(posn, rad, course, rangeOfSensors, spanOfSensors, noOfSensors);
        [sBinStr_o, sBinStr_t, dist_o, dist_t, dist_o1, th, th_o, th_g]  = sensorModule2a(posn, rad, course, course1, rangeOfSensors, spanOfSensors, noOfSensors);        
        sDep                = rangeOfSensors;
        sSpan               = spanOfSensors;     
        sBinStr_l           = noOfSensors;
        sDepPalette(ll)     = rangeOfSensors;
        sSpanPalette(ll)    = spanOfSensors;
        
        % Store AIS parameters for final ploting
        spanInDegree = sSpan*180/pi;
        AIS_SenseTrace = [AIS_SenseTrace; noOfSensors, sDep, spanInDegree];
        AIS_ContTrace = [AIS_ContTrace; robotPlan(1:3)];
        AIS_ABBSTrace = [AIS_ABBSTrace; maxAffAB];
        
        title(strcat('Number of sensors = ',num2str(noOfSensors), '; Depth of sensing = ', num2str(sDep),...
            '; Span of sensors = ', num2str(spanInDegree)), 'FontSize', 14);
        xlabel(strcat('Navigation : ', robotPlan), 'FontSize', 14);
        % Update Robot's Wheel model
        % Update Robot's Control type
        
        % Update Robot's Planning Algorithm
        % -----------------------------------------------------------------
        if (strcmp(robotPlan, 'RIN'))
            heading = RIN(RIN_param, th_g, dist_o, th);
        elseif (strcmp(robotPlan, 'SSHT'))
            heading = SSHT(posn, th, dist_o, sDep, rho1, course, curTar);
        elseif (strcmp(robotPlan, 'CVM'))
            %heading = VFH(posn, dist_o, th, sDep, curTar, sSpan);
            heading = CVM(CVM_param, posn, obstacles, dist_o, th, curTar, th_g);
        end
        
        [a, b] = size(heading);
        if (b == 1)
            theta = heading;
        else
            [thC, thT] = max(heading);
            theta = (th(thT));
        end
      
        % -----------------------------------------------------------------
        if (tS>5)
            infVal = CalculateInflamation(positionTrace, collisionTrace, rho1, infSteps);
        end
        if (loop_count > infSteps-1)
            if (infVal > infThreshold)
                % Create New Generation
                antiBodies = CSAantiBodiesGenerate(noAB);
                loop_count = 0; 
            end    
        end
        
        AIS_InflTrace(tS) = infVal;
        loop_count = loop_count + 1;
    end
    
    if (mod(tS, 10) == 0)
        text(posn(1), posn(2), strcat(' \leftarrow', num2str(tS)), 'FontSize', 14, 'Color', 'r');
    end
    
    [EE, negR, kappa] = energyFa3(posn, sBinStr_l, sBinStr_o, sBinStr_t, dist_o, sDep, energy, ES, negR, maxEnergy);
    %[EE, negR, kappa] = energyFa(posn, noOfSensors, sBinStr_o, sBinStr_t, dist_o, sDep, energy, ES, negR, maxEnergy);

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
    
    orientation         = posn_p(3);
    collision           = kappa(1,thT);
    energy              = EE(1,thT);
    icPalette(ll,:)     = posn;
    energyPalette(ll)   = energy;
    idPalette(ll)       = ID;
    orienPalette(ll)    = orientation;
    tarPer              = tagRescue;

    orientationTrace    = [orientationTrace, orientation];
    collisionTrace      = [collisionTrace, collision];
    energyTrace         = [energyTrace, energy];
    idTrace             = [idTrace, ID];
    idPalette(ll)       = ID;

    % plot sensor span
    plotSensorGeneral(h1, posn_p, rad, sDep_plot, sSpan_plot, [0, 0, 0]+0.85);
    plotSensorGeneral(h1, posn, rad, sDep, sSpan, 'k');
        
    tS = tS + 1;
    ii = ii + dt;
    if nTarg == 0; break; end
end
thyme = toc;

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Results
TT = tF;
tt = ii;
mm = MM-nTarg;
HH = 1;             % start of simulation is the only human interaction
MS = 50*((mm/MM) + 1 - (tt/TT))/(HH*HH);
CC = nnz(collisionTrace);   % non-zero matrix elements

Results = [thyme tt CC MS]';
Traces = [positionTrace', collisionTrace',  energyTrace', inflammationTrace', idTrace', AIS_SenseTrace, AIS_ContTrace, AIS_ABBSTrace];

p = profile('info');

name = strcat(arenaName, '_results_', num2str(fix(thyme*100)));

path1 = pwd;
path2 = strcat(path1,'\results\');
fullName = strcat(path2,name);
save(fullName,'p','Results','Traces','tSwitch', 'patchesT');

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% path = sprintf(basePath); imwrite
print('1-Arena Navigation', '-djpeg');

% fig2 = figure(2);
% fig3 = figure(3);

figure(2);
hold on;
subplot(3,1,1),
plot(energyTrace(1:end),'g'),
axis([0 length(energyTrace) min(energyTrace)-5, max(energyTrace)+5]);
ylabel('Energy Trace')

subplot(3,1,2),
plot(collisionTrace(1:end),'g')
axis([0 length(collisionTrace) -0.5 1.5]);
ylabel('Collision Trace')
%xlabel('Simulation Steps')

subplot(3,1,3),
plot(AIS_InflTrace(1:end),'g')
axis([0 length(collisionTrace) 0, 1]);
ylabel('Inflamation Trace')
xlabel('Simulation Steps')
hx = refline(0, infThreshold);
set(hx, 'Color', 'r', 'LineStyle', '--')
% highInflIndices = find(AIS_InflTrace>infThreshold);
% for i = 1:length(highInflIndices)
%     indiceNum = highInflIndices(i);
%     text(indiceNum, AIS_InflTrace(indiceNum), strcat(' \leftarrow', 'High Inflamation'), 'FontSize', 14, 'Color', 'r');
% end

print('2-Energy, Collision and Inflamation Traces', '-djpeg');

figure(3);

subplot(4,1,1), bar(AIS_SenseTrace(1:end, 1), 'g'); 
%title('Number of Sensors');
legend('Number of Sensors');
axis([0 length(collisionTrace) 10, 50]);
ylabel('number')
%xlabel('Simulation Steps')

subplot(4,1,2), bar(AIS_SenseTrace(1:end, 2), 'r'); 
%title('Range of Sensors');
legend('Depth of Sensing');
axis([0 length(collisionTrace) 20, 110]);
ylabel('pixels')
%xlabel('Simulation Steps')

subplot(4,1,3), bar(AIS_SenseTrace(1:end, 3), 'b'); 
%title('Span of Sensors');
legend('Span of Sensors');
axis([0 length(collisionTrace) 25, 370]);
ylabel('degree')
%xlabel('Simulation Steps')

numContTrace = str2num4ContTrace(AIS_ContTrace);
subplot(4,1,4), bar(numContTrace, 'k'); 
%title('Span of Sensors');
legend('Planning Algorithm');
axis([0 length(collisionTrace) 0, 5]);

%set(gca, 'YTickLabel', ['RND', 'RIN', 'SSHT']);
%ylabel('Span of Sensors')
xlabel('Simulation Steps')

print('3-AIS Traces', '-djpeg');

figure(4);
plot(AIS_SenseTrace(1:end, 1),'g')
hold all
plot(AIS_SenseTrace(1:end, 2),'r')
plot(AIS_SenseTrace(1:end, 3),'b')
title('Sensors Trace');
legend('Number of Sensors', 'Depth of Sensing', 'Span of Sensors');
xlabel('Simulation Steps')

print('4-Sensor Traces', '-djpeg');

figure(5);
load(arenaName, 'arena', 'obstacles', 'targets') 
arenaSize = [arena(1,2) arena(1,3) arena(3,4) (arena(3,3)+arena(3,5))];
[arena, obstacles, targets] = recreateArena(arenaSize, arena, obstacles, targets);
course = rgb2gray(imread(arenaName,'png'));
course = flipud(course);
course = imresize(course, [600 840]);
course = arenaTuning(course);   % removes unwanted pixels values generated by 'imresize'
h1 = imshow(course);    % handle to the image object created by imshow
axis image off; 
%colormap gray;
plotSensor(h1, plotPosn, rad, plotSDep, plotSpan);
[sBinStr_o, sBinStr_t, dist_o, dist_t, dist_o1, th, th_o, th_g]   = sensorModule1c(plotPosn, rad, course, plotSDep, plotSpan, plotNoOfSensors);

for k=1:length(positionTrace)
    plotRobot1(h1, positionTrace(:, k), SF, clr)
end
print('5-Arena Navigation without Sensor', '-djpeg');