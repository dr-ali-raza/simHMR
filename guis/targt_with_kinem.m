function [clls nrg al]=targt_with_kinem(bc,cd,de,ef,ij,jk,hi,arenaName)
%clear; close all;
global sBinStr_l sBinStr_o sBinStr_t Dist th th_g Dist1 th1 th_g1 sBinStr_l1 sBinStr_o1 sBinStr_t1
global aa mi tag1 positionTrace orientationTrace FT mi1 mi2 ki ai thT th thT1 th1 kappa EE
global course rad alpha beta gamma
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
addpath(genpath(path1));

%nTarg=alphs;

TARGET=hi;
[targSr targSc] = size(TARGET);
nTarg          = targSr;
% ========================================================================
% Experiment configuration

ic1         = [50 50 pi/2];
ic2         = [400 50 pi/2];
ic3         = [800 50 pi/2];
ic4         = [50 300 pi/2];
ic5         = [800 300 pi/2];
ic6         = [50 500 pi/2];
ic7         = [400 550 0];
ic8         = [800 550 pi];
tic
rad         = 10;
SF          = 10;

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
tF          = 40;

% ========================================================================
% Plotting configuration
%recallArena =1;

%arenaName = 'S1_1c';

%  load(arenaName, 'arena', 'obstacles', 'targets')

%  arenaSize = [arena(1,2) arena(1,3) arena(3,4) (arena(3,3)+arena(3,5))];
% [arena obstacles targets] = recreateArena(arenaSize, arena, obstacles, targets);
%[obstSr obstSc] = size(obstacles);
%[targSr targSc] = size(targets);
%nObst          = obstSr;
%nTarg          = targSr;


% ========================================================================
% Initial plots

course = rgb2gray(imread(arenaName,'png'));
course=imrotate(course,270);
course = flipud(course);
course = imresize(course, [600 840]);
h1 = imshow(course); axis image off; colormap gray;
hold on;

[ES] = energySource(esLocX,esLocY);
%course=jk;
% ========================================================================
positionTrace       = [];
collisionTrace      = [];
energyTrace         = [];
orientationTrace    = [];
inflammationTrace   = [];
idTrace             = [];

%nR                  = 1;
nRmax               = 7;    % maximum number of robots (for specifying colors only)
%icPalette           = [ic2;ic8;  ic3; ic4; ic5; ic6; ic7; ic8];
clrs                = [.6 .4 .4;.2 .4 .4;  .2 .2 .4; .4 .4 .2; .6 .2 .4; .6 .4 .2; .4 .4 .4 ];
clrPalette          = [(1:nRmax)' clrs];
%sDepPalette         = [250; 350; 250; 250; 250; 250; 250];
%sSpanPalette        = [2*pi/3; 2*pi/2; 2*pi/3; 2*pi/3; 2*pi/3; 2*pi/3; 2*pi/3];
sBinStr_lPalette    = [ 20;16; 30; 16; 30; 20; 25];
energyPalette       = [maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy; maxEnergy];
idPalette           = [1; 1; 1; 1; 1; 1; 1];

%orienPalette        = icPalette(:,end);
tag1        = 0;
tag2        = 1;
esLocX      = 150;            % Energy Source location
esLocY      = 450;
maxEnergy   = 3000;
energy      = maxEnergy;
negR        = 0;
thT         = 1;
% ii          = 1;
tagSearch   = 1;
tagSearch1   = 1;
tagRescue   = 0;

% Initial plots prior to start of AIS-based algorithm

%ab=KINEM;
nR=bc;
icPalette=cd;
sSpanPalette= de;
sDepPalette  =ef;
%fg=ARENA;
%gh=OBSTACLES;
%hi=TARGET;
%h1=ij;
%course=jk;
% user_without_kinem3(ab,bc,cd,de,ef,fg,gh,hi,ij,jk)

ii=1;
endtime = 350;
alpha=icPalette(1,1);
beta=icPalette(1,2);
gamma=icPalette(1,3);
IC = [alpha beta gamma 0 0 0 0];
[t,q]  = ode23s(@f_mr3133, [0 endtime], IC);
%path = size(t);
%Na  = path(1,1);%
Xc1=q(:,1);
Yc1=q(:,2);
phi31=q(:,3);
position1=[Xc1 Yc1 phi31];
i=1;
% ========================================================================
%Xc=800;
%Yc=550;
%phi3=pi;
%position=[Xc Yc phi3];
collisionTrace      = [];
energyTrace         = [];
for kk = 1:nR
    tag1 = 0;
    plotRobot1(h1, icPalette(kk,:), SF, clrPalette(kk,2:4));
    plotSensor(h1, icPalette(kk,:), rad, sDepPalette(kk), sSpanPalette(kk));
    [sBinStr_o sBinStr_t dist_o dist_t dist_o1 th th_o th_g]   = sensorModule1c(icPalette(kk,:), rad, course, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));
    %if kk == 1;
    %end
end

while((nTarg ~= 0) | (tagSearch ==1) | (tagRescue == 1)) & (tS <= tF)
    posn23    =[position1(i,1) position1(i,2) position1(i,3)];
    clr             = clrPalette(1,2:4);
    plotRobot1(h1, posn23, SF, clr)
    drawnow;
    tS = tS + 1;
    i=i+2;
    collisi           = kappa(1,thT);
    energi             = EE(1,thT);
    collisionTrace      = [collisionTrace collisi];
    clls=collisionTrace;
    energyTrace         = [energyTrace energi];
    nrg=energyTrace ;
end

al=toc;