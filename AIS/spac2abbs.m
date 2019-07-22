function bitstring = spac2abbs(sensNo, sensRange, sensSpan, wheelModel, controlType, planAlgo)
%spac2abbs takes Sensors (s), Plan (p), Actuators (a) and Control (c)
%parameters and returns Anti-body Bitstring (abbs).
%--------------------------------------------------------------------------
% Input Variable:
%   sensNo -> number of sensors of robot
%   sensRange -> range (depth) of sensors
%   sensSpan -> span (field) of sensors
%   wheelModel -> one of five wheel model
%   controlType -> controller of robot
%   planAlgo -> reactive search algorithm
% Output Variable:
%   bitstring -> bitstring represention (antibody) of sensors, actuators,
%   control and planning
%==========================================================================
% Sample Function Callings:
% 1. spac2abbs(48, 200, 360, 'Type11', 'Lin', 'RIN')
% 110000 011001000 101101000 100 01 001

% verifying the value limits
%--------------------------------------------------------------------------
sensNo = LimitFunc(sensNo, 48); % maximum number of sensors = 48
sensRange = LimitFunc(sensRange, 350); % maximum range of sensors = 350
sensSpan = LimitFunc(sensSpan, 360); % maximum span of sensors = 360


% set number of bits (in bitstring) to each parameter
%--------------------------------------------------------------------------
sensNo_bits = 6; 
sensRange_bits = 9; 
sensSpan_bits = 9; 


% forming antibody bitstring
%--------------------------------------------------------------------------
% Sensors parameters
sensNo_str = num2str(de2bi(sensNo, sensNo_bits, 'left-msb'));
sensRange_str = num2str(de2bi(sensRange, sensRange_bits, 'left-msb'));
sensSpan_str = num2str(de2bi(sensSpan, sensSpan_bits, 'left-msb'));

% Actuator types
if (strcmp(wheelModel, 'Type30'))
    wheelModel_str = '001';
elseif (strcmp(wheelModel,'Type20'))
    wheelModel_str = '010';
elseif (strcmp(wheelModel, 'Type21'))
    wheelModel_str = '011';
elseif (strcmp(wheelModel, 'Type11'))
    wheelModel_str = '100';
elseif (strcmp(wheelModel, 'Type12'))
    wheelModel_str = '101';
else
    wheelModel_str = '000';
end

% Control types
if (strcmp(controlType, 'Lin'))
    controlType_str = '01';
elseif (strcmp(controlType,'nLin'))
    controlType_str = '10';
else
    controlType_str = '00';
end

% Plan Algorithms
if (strcmp(planAlgo, 'RIN'))
    planAlgo_str = '001';
elseif (strcmp(planAlgo,'SSHT'))
    planAlgo_str = '010';
elseif (strcmp(planAlgo, 'CVM'))
    planAlgo_str = '011';
else
    planAlgo_str = '000';
end

% Concatinating the strings
%--------------------------------------------------------------------------
bitstring_can = strcat(sensNo_str, sensRange_str, sensSpan_str, wheelModel_str, ...
    controlType_str, planAlgo_str); % string concatenation

% Remove extra empty spaces
%--------------------------------------------------------------------------
bitstring = blanks(length(bitstring_can));
j = 1;

for i=1:length(bitstring_can)
    if(bitstring_can(i) == '1' || bitstring_can(i) == '0')
        bitstring(j) = bitstring_can(i);
        j = j +1;
    end
end

% Final (anti-body) Bitstring after removing white spaces
%--------------------------------------------------------------------------
bitstring = strtrim(bitstring);

end