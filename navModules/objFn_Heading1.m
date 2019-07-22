% Sample Navigation Strategy using 'objective function' approach
%
% Written by Ali Raza, (c) 2018
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function [objFn_H1_out] = objFn_Heading1(sensorOut, C_BinStr_l, C_dep)

sFactor = 0.1;
nVectors = 50;
w_OA = 1;       % weight of obstacle avoidance behavior
w_GS = 1;       % weight of goal seeking behavior

sizeFactor      = size(1:C_BinStr_l);
f_OA            = ones(sizeFactor);
f_GS            = zeros(sizeFactor);

for j = 1:C_BinStr_l
    if sensorOut(3,j)<C_dep
        f_OA(j) = sensorOut(3,j)/C_dep;
    end
end

m = floor(sFactor*nVectors);        % window size for filter (general)
m1 = floor(sFactor*nVectors);     % window size for filter (goal seeking)
% m1 = m;

% Adj1 = sensorOut(6,:) - sensorOut(8,:);
% f_GS = 1 - (abs(Adj1)/pi);
f_GS = sensorOut(5,:);

%=====================================================================
% Alternative approach for goal seeking function
% th2 = npi2pi(sensorOut(6,:),'radians');
% th_g2 = npi2pi(sensorOut(8,:),'radians');
% f_GS1 = 1 - abs((th2-th_g2)/pi);
%=====================================================================
% Alternative approach for goal seeking function
for j = 1:C_BinStr_l
    f_GS1a(j) = (1 - cos(sensorOut(8,j)-sensorOut(6,j)))/2;
end
f_GS1 = sensorOut(5,:) + f_GS1a;

%=====================================================================

% f_OA_fltd = medfilt1(f_OA,m);
f_OA_fltd = filtfilt(ones(1,m)/m,1,f_OA);
f_GS_fltd = filtfilt(ones(1,m1)/m1,1,f_GS);
f_GS1_fltd = filtfilt(ones(1,m1)/m1,1,f_GS1);

F_th1 = (w_OA*f_OA_fltd) + (w_GS*f_GS_fltd);
F_th2 = (1-w_OA*(1-f_OA_fltd)).*(1-w_GS*(1-f_GS_fltd));
objFn_H1_out = [F_th1; F_th2; f_OA; f_OA_fltd; f_GS; f_GS_fltd; f_GS1; f_GS1_fltd];