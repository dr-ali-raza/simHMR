function [heading] = RIN(param, goalAngle, obsDist, th)
% RIN is implementation of Reactive Immune Network Algorithm as proposed in
% "An Immunological Approach to Mobile Robot Navigation" proposed by
% Guan-Chun Luh and Wei-Wen Liu
%
% University of Engineering and Technology, Lahore, Pakistan
%--------------------------------------------------------------------------
% Input Variable:
%   param -> containers contain different parameters related to RIN
%   algorithm
%   robot -> location of robot in arrena [x, y, dir]
%   target -> position of target in the arrena [x, y, xspan, yspan]
%   senOrien -> orientations of installed sensors 
%   obstacles -> location of obstacles in the arrena
%   obsDist -> distance of obstacles from each sensor
%   senRange -> range of distance sensors
% Output Variable:
%   heading -> contains value of direction (angle) heading towards goal
% =========================================================================

global Nab antiBodies affinity mss deathRate
sSpan = length(th);

% --------------------- Anti-bodies and Sensors
antiBodies = th;
sensors = th;
Nab = sSpan;
Ns = sSpan;

% --------------------- Attractive force towards goal
fGoal = (1 + cos(antiBodies-goalAngle))/2;

% --------------------- Repulsive force away from obstacles
% Evulating delta
for a = 1:Nab
    delta(a, :) = (1 + cos(antiBodies(a)-sensors))/2;
end

% Evulating alpha
alpha = exp(-Ns*(1-delta));

% Normalized distance
obsDistN = normalizedObsDistance(obsDist);

% Evaluating obstacle force
for a = 1:Ns
    fObs(a) = sum(alpha(:, a)*obsDistN(a));
end

% --------------------- Affinity of anti-bodies
affinity = 0.7*fGoal + 0.3*fObs;

% --------------------- Evaluation of stimulus of anti-bodies
% Evaluating stimulative-suppressive affinity
for i = 1:Nab
    for k = 1:Nab
        mss(i, k) = cos(antiBodies(k) - antiBodies(i));
    end
end

% Antibodies death reate
deathRate = zeros(1, Nab);

% Differential equation solution
tspan = 1:0.1:10;
y0 = zeros(1, Nab); % Intial condition
 
[T, Y] = ode45(@stimulus, tspan, y0);

[x, y] = max(Y(Nab, :));
% [x, y] = max(affinity);
heading = antiBodies(y);

end