function [collisionTrace energyTrace appli]=target1_without_kinem(bc,cd,de,ef,hi,arenaN,ij,jk )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to search targets without robot-kinematics
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global sBinStr_l sBinStr_o sBinStr_t Dist th th_g Dist1
global aa mi tag1 positionTrace orientationTrace FT mi1 mi2 ki ai thT th
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
addpath(genpath(path1));
set(0,'DefaultFigureWindowStyle','docked')

% ========================================================================
% Experiment configuration

arenaName = arenaN;
TARGET=hi;
load(arenaName,'ARENA','OBSTACLES', 'TARGET');
tic
[targSr targSc] = size(TARGET);
nTarg          = targSr;

rad         = 10;
SF          = 10;
course      = jk;
h1          = ij;
tag1        = 0;
tag2        = 1;
esLocX      = 150;            % Energy Source location
esLocY      = 450;
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
tF          = 300;

% ========================================================================
% Initial plots
% figure
course = rgb2gray(imread(arenaName,'png'));
course = flipud(course);
course = imresize(course, [600 840]);
h1 = imshow(course); 
% axis image off; 
colormap gray;
hold on;

[ES] = energySource(esLocX,esLocY);

% ========================================================================
positionTrace       = [];
collisionTrace      = [];
energyTrace         = [];
orientationTrace    = [];
inflammationTrace   = [];
idTrace             = [];

nRmax =4;
nR=bc;
sBinStr_lPalette    = [16; 30; 20; 16];
clrs                = [.2 .4 .4; .6 .4 .4; .2 .2 .4; .4 .4 .2];
clrPalette          = [(1:nRmax)' clrs];
sDepPalette =ef;
sSpanPalette=de;
icPalette =cd;  % maximum number of robots (for specifying colors only)
energyPalette       = [maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy];
idPalette           = [1; 1; 1; 1; 1; 1; 1];
incmpNames          = {'posn', 'clr', 'sDep', 'sSpan', 'sBinStr_l', 'energy'};
orienPalette        = icPalette(:,end);

% Initial plots prior to start of AIS-based algorithm
for kk = 1:nR
    plotRobot1(h1, icPalette(kk,:), SF, clrPalette(kk,2:4));
    [sBinStr_o sBinStr_t dist_o dist_t dist_o1 th th_o th_g]   = sensorModule1c(icPalette(kk,:), rad, course, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));
    %if kk == 1;
    tag1 = 0; %end
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
while((nTarg ~= 0) | (tagSearch ==1) | (tagRescue == 1)) & (tS <= tF)
    
    
    posn            = icPalette(ll,:);
    clr             = clrPalette(ll,2:4);
    sDep            = sDepPalette(ll);
    sSpan           = sSpanPalette(ll);
    sBinStr_l       = sBinStr_lPalette(ll);
    energy          = energyPalette(ll);
    ID              = idPalette(ll);
    orientation     = orienPalette(ll);
    
    positionTrace   = [positionTrace posn'];
    
    [sBinStr_o sBinStr_t dist_o th th_g dist_t] = sensorModule1(posn, rad, course, sDep, sSpan, sBinStr_l);
    [F_th1 F_th2 f_OA f_OA_fltd f_GS f_GS_fltd f_GS1 f_GS1_fltd] = objFn_Heading(th, th_g, dist_o, sBinStr_l, sDep, dist_t);
    [thC thT] = max(F_th1);
    theta = (th(thT));
    
    [EE negR kappa] = energyFa(posn, sBinStr_l, sBinStr_o, sBinStr_t, dist_o, sDep, energy, ES, negR, maxEnergy);
    
    stepSize = 9;
    incr1_max = 5; % odd number
    dist_acc = 0;
    for incr1 = 1:1:(incr1_max-1)/2
        if (thT == length(sBinStr_o))|(thT == length(sBinStr_o)-incr1+1)
            dist_oo(incr1) = dist_o(thT);
        else
            dist_oo(incr1) = dist_o(thT+incr1);
        end
    end
    dist_acc = sum(dist_oo);
    for incr1 = (incr1_max-1)/2:-1:1
        if thT == 1
            dist_oo(incr1) = dist_o(thT);
        elseif((thT-incr1)==0)
            dist_oo(incr1) = dist_o(thT);
        else
            dist_oo(incr1) = dist_o(thT-incr1);
        end
    end
    dist_acc = dist_acc + sum(dist_oo);
    rho1 = stepSize*((dist_o(thT) + dist_acc)/(incr1_max*sDep));
    
    % =======================================================================
    diffVal = 60;
    if (tagSearch == 1)
        [prx pry] = pol2cart(theta,rho1);
        posn_p = posn;
        posn = [posn(1)+prx posn(2)+pry theta];
        N_targP = nTarg;
        plotRobot1(h1, posn, SF, clr)
        drawnow;
               
        for i =1:nTarg
            diffX = abs(posn(1)-(TARGET(i,2)+(TARGET(i,4)/2)));
            diffY = abs(posn(2)-(TARGET(i,3)+(TARGET(i,5)/2)));
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
                abc = floor(TARGET(tInd(i),2)-28:(TARGET(tInd(i),2)+TARGET(tInd(i),4)+28));
                bcd = floor((TARGET(tInd(i),3)-28):(TARGET(tInd(i),3)+TARGET(tInd(i),5)+28));
                cInfo1(bcd,abc) = 0;
                course(bcd,abc)=255;
                ID = 3;
            end
        end
    end
    if (tagRescue == 1)
        [prx pry] = pol2cart(theta,rho1);
        posn_p = posn;
        posn = [posn(1)+prx posn(2)+pry theta]
        N_targP = nTarg;
        plotRobot1(h1, posn, SF, clr)
        %drawnow;
        
        diffX = abs(posn(1)-(TARGET(tInd(tag3),2)+(TARGET(tInd(tag3),4)/2)));
        diffY = abs(posn(2)-(TARGET(tInd(tag3),3)+(TARGET(tInd(tag3),5)/2)));
        if (diffX < diffVal) && (diffY < diffVal)
            TARGET(tInd(tag3),1) = 0;
            cInfo = get(h1, 'CData');
            abc = floor(TARGET(tInd(tag3),2)-28:(TARGET(tInd(tag3),2)+TARGET(tInd(tag3),4)+28));
            bcd = floor((TARGET(tInd(tag3),3)-28):(TARGET(tInd(tag3),3)+TARGET(tInd(tag3),5)+28));
            cInfo(bcd,abc) = 200;
            set(h1, 'CData', cInfo);
            course(bcd,abc)=255;
            drawnow;
            TARGET(tInd(tag3),:) = [];
            nTarg = nTarg - 1;
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
    % =======================================================================
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
appli=toc;