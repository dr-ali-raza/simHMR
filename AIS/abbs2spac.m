function [sensNo, sensRange, sensSpan, wheelModel, controlType, planAlgo] = abbs2spac(bitstring)
%spac2abbs takes Anti-body Bitstring (abbs) and returns Sensors (s), 
% Plan (p), Actuators (a) and Control (c) parameters of mobile robot
% control
%--------------------------------------------------------------------------
% Input Variable:
%   bitstring -> bitstring represention (antibody) of sensors, actuators,
%   control and planning
% Output Variable:
%   sensNo -> number of sensors of robot
%   sensRange -> range (depth) of sensors
%   sensSpan -> span (field) of sensors
%   wheelModel -> one of five wheel model
%   controlType -> controller of robot
%   planAlgo -> reactive search algorithm
%==========================================================================
% Sample Function Callings:
% 1. [sensNo, sensRange, sensSpan, wheelModel, controlType, planAlgo] 
%       = abbs2spac('11000001100100010110100010001001')
% [48, 200, 360, 'Type11', 'Lin', 'RIN']

% Spliting Bitstring
%--------------------------------------------------------------------------
sensNo_str = bitstring(1:6);
sensRange_str = bitstring(7:15);
sensSpan_str = bitstring(16:24);
wheelModel_str = bitstring(25:27);
controlType_str = bitstring(28:29);
planAlgo_str = bitstring(30:32);

% Getting Sensor parameters
%--------------------------------------------------------------------------
sensNo = bin2dec(sensNo_str);
sensRange = bin2dec(sensRange_str);
sensSpan = bin2dec(sensSpan_str);

% Sensor parameters limits
%--------------------------------------------------------------------------
sensNo = LimitFunc(sensNo, 48); % maximum number of sensors = 48
sensRange = LimitFunc(sensRange, 350); % maximum range of sensors = 350
sensSpan = LimitFunc(sensSpan, 360); % maximum span of sensors = 360

% Getting Actuator types
%--------------------------------------------------------------------------
if (strcmp(wheelModel_str, '001'))
    wheelModel = 'Type30';
elseif (strcmp(wheelModel_str, '010'))
    wheelModel = 'Type20';
elseif (strcmp(wheelModel_str, '011'))
    wheelModel = 'Type21';
elseif (strcmp(wheelModel_str, '100'))
    wheelModel = 'Type11';
elseif (strcmp(wheelModel_str, '101'))
    wheelModel = 'Type12';
else
    wheelModel= 'nill';
end

% Getting Control types
%--------------------------------------------------------------------------
if (strcmp(controlType_str, '01'))
    controlType = 'Lin';
elseif (strcmp(controlType_str, '10'))
    controlType = 'nLin';
else
    controlType = 'nill';
end

% Getting Plan Algorithms
%--------------------------------------------------------------------------
if (strcmp(planAlgo_str, '001'))
    planAlgo = 'RIN';
elseif (strcmp(planAlgo_str, '010'))
    planAlgo = 'SSHT';
elseif (strcmp(planAlgo_str, '011'))
    planAlgo = 'CVM';
else
    planAlgo = 'nill';
end

end