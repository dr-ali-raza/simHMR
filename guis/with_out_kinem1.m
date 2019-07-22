function with_out_kinem1(dd,cc,aaa,bb)
global sBinStr_l sBinStr_o sBinStr_t Dist th th_g Dist1
global aa mi tag1 positionTrace orientationTrace FT mi1 mi2 ki ai thT th
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
addpath(genpath(path1));

arenaName = strcat(path2,'S_c');
load(arenaName,'ARENA','OBSTACLES', 'TARGET')
arenaSize = [ARENA(1,2) ARENA(1,3) ARENA(3,4) (ARENA(3,3)+ARENA(3,5))];

[obstSr obstSc] = size(OBSTACLES);
[targSr targSc] = size(TARGET);
nObst           = obstSr;
nTarg           = targSr;
MM              = nTarg;
course = rgb2gray(imread(arenaName,'png'));
% course=imrotate(course,270);
course = flipud(course);
course = imresize(course, [600 840]);
h1 = imshow(course); 
% axis image off; 
colormap gray;
hold on;

SF=10;
rad=10;
nRmax =4;
nR=dd;
sBinStr_lPalette    = [16; 30; 20; 16];
clrs                = [.2 .4 .4; .6 .4 .4; .2 .2 .4; .4 .4 .2];
clrPalette          = [(1:nRmax)' clrs];
sDepPalette =bb;
sSpanPalette=aaa;
icPalette =cc;
for kk = 1:nR
    tag1 = 0;
    plotRobot1(h1, icPalette(kk,:), SF, clrPalette(kk,2:4));
    [sBinStr_o sBinStr_t dist_o dist_t dist_o1 th th_o th_g]   = sensorModule1c(icPalette(kk,:), rad, course, sDepPalette(kk), sSpanPalette(kk), sBinStr_lPalette(kk));
end