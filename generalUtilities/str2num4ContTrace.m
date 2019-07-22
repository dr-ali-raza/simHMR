function [ numContTrace ] = str2num4ContTrace( strContTrace )
%str2num4ContTrace will take a matrice with elements represented by
% predefined string values and will convert to specified integar values
%--------------------------------------------------------------------------
% Input Variable:
%   strContTrace -> contains elements from set {'nil', 'RIN', 'CVM', 'SSH'}
% Output Variable:
%   numContTrace -> will contain elements in range 0-3 with mapping
%   specified in the implementation of the function
%==========================================================================
% Sample Function Callings:
% 1. numTrace = str2num4ContTrace(strTrace)
% Department of Mechatronics and Control Engineering, UET Lahore
%--------------------------------------------------------------------------
% START OF FUNCTION
for i=1:length(strContTrace)
    if (strcmp(strContTrace(i, :), 'nil'))
        val(i) = 1;
    elseif (strcmp(strContTrace(i, :), 'RIN'))
        val(i) = 2;
    elseif (strcmp(strContTrace(i, :), 'SSH'))
        val(i) = 3;
    elseif (strcmp(strContTrace(i, :), 'CVM'))
        val(i) = 4;
    end
end

numContTrace = val;
%--------------------------------------------------------------------------
% END OF FUNCTION
end

