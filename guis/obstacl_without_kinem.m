function [collisionTrace energyTrace appli]=obstacl_without_kinem(bc,cd,de,ef,hi,arenaN,ij,jk )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obstacle Avoidance without Robot-Kinematics
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global sBinStr_l sBinStr_o sBinStr_t Dist th th_g Dist1
global aa mi tag1  orientationTrace FT mi1 mi2 ki ai thT th
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
addpath(genpath(path1));
arenaName = arenaN;
tic
TARGET=hi;
% [obstSr obstSc] = size(OBSTACLES);
[targSr targSc] = size(TARGET);
% nObst          = obstSr;
nTarg          = targSr;
% nTarg            = nTar;
h1=ij;
% jk=course1;
course=jk;
% ========================================================================

tag1        = 0;
tag2        = 1;
esLocX      = 150;            % Energy Source location
esLocY      = 450;
maxEnergy   = 3000;
energy      = maxEnergy;
negR        = 0;
thT         = 1;
[ES] = energySource(esLocX,esLocY);
energyTrace         = [];
collisionTrace      = [];
SF=10;
rad=10;
nRmax =4;
nR=bc;
sBinStr_lPalette    = [16; 30; 20; 16];
clrs                = [.2 .4 .4; .6 .4 .4; .2 .2 .4; .4 .4 .2];
clrPalette          = [(1:nRmax)' clrs];
sDepPalette =ef;
sSpanPalette=de;
icPalette =cd;

patchesT    = zeros(2*nTarg,200);
patchI      = 1;

jj          = 1;
ii          = 1;
nn          = 1;
ll          = 1;
% tInd        = 0;
tInd        = zeros(1,nTarg);
tagSearch   = 1;
tagRescue   = 0;
tSwitch     = [];
tag3        = 0;

posn1       = icPalette(1,:);
posn        = posn1;
posn_p      = [posn(1)-2 posn(2)-2 posn(3)];

for kk = 1:nR
    tag1 = 0;
    plotRobot1(h1, icPalette(kk,:), SF, clrPalette(kk,2:4));
    [sBinStr_o sBinStr_t dist_o dist_t dist_o1 th th_o th_g]=sensorModule1c(icPalette(kk,:), rad, course, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));
end
tS          = 1;
tF          = 150;

while((nTarg ~= 0) | (tagSearch ==1) | (tagRescue == 1)) & (tS <= tF)
    
    posn            = icPalette(1,:);
    clr             = clrPalette(1,2:4);
    sDep            = sDepPalette(1);
    sSpan           = sSpanPalette(1);
    sBinStr_l       = sBinStr_lPalette(1);
    
    [sBinStr_o sBinStr_t dist_o th th_g dist_t] = sensorModule1t(posn, rad, course, sDep, sSpan, sBinStr_l);
    [F_th1 F_th2 f_OA f_OA_fltd f_GS f_GS_fltd f_GS1 f_GS1_fltd] = objFn_Headingt(th, th_g, dist_o, sBinStr_l, sDep, dist_t);
    [thC thT] = max(F_th1);
    [EE negR kappa] = energyFa(posn, sBinStr_l, sBinStr_o, sBinStr_t, dist_o, sDep, energy, ES, negR, maxEnergy);
    theta = (th(thT));

    stepSize = 7;
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
    
    if (tagSearch == 1)
        [prx pry] = pol2cart(theta,rho1);
        posn_p = posn;
        posn = [posn(1)+prx posn(2)+pry theta];
%         N_targP = nTarg;
        plotRobot1(h1, posn, SF, clr)
        drawnow;
    end
    icPalette(1,:)     = posn;
    tS = tS + 1;
    collision           = kappa(1,thT);
    energy              = EE(1,thT);
    collisionTrace      = [collisionTrace collision];
    energyTrace         = [energyTrace energy];
end
appli=toc;
