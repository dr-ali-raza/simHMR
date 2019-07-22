function antibodies = CSAantiBodiesGenerate(noOfAb, previousPop)
%CSAInitialization randomly generates initial population of antibodies
%--------------------------------------------------------------------------
% Input Variable:
%   noOfAb -> number of antibodies to be generated
%   previousPop -> previous population of antibodies
% Output Variable:
%   antibodies -> an array of antibodies in bitstring represention 
%==========================================================================
% Sample Function Callings:
% 1. CSAantiBodiesGenerate(5)
%
% 10100001111000100100101110101010
% 00011000111110000110100001110010
% 00001000001001100011001010001011
% 10010001010111001100001001010001
% 10001001110100001100111101010001

%--- LOCAL VARIABLES
%--------------------------------------------------------------------------
maxNumber4byte = 4294967295;
noOfBits4byte = 32;
sesorMax = 48;  % maximum number of sensors = 48
rangeMax = 100; % maximum range of sensors = 100
spanMax = 360; % maximum span of sensors = 360
sensorMin = 12; % minimum number of sensors = 12
rangeMin = 25; % minimum range of sensors = 25
spanMin = 30; % minimum span of sensors = 30

RINab = ceil(noOfAb/2);
SSHTab = ceil(noOfAb/2);
CVMab = noOfAb-RINab-SSHTab;
RINcount = 0;
SSHTcount = 0;
CVMcount = 0;


k = 1;

for h = 1:10000
    %---- GENERATE A RANDOM ANTIBODY
    %--------------------------------------------------------------------------
    antibodies_dobuleNum = randi(maxNumber4byte, [1, 1]);
    antibodies_bitstring = num2str(de2bi(antibodies_dobuleNum, noOfBits4byte, 'left-msb'));
    
    %---- RMOVE EXTRA EMPTY SPACES
    %--------------------------------------------------------------------------
    antibodies_intialPop = blanks(length(antibodies_bitstring));
    j = 1;
    for i=1:length(antibodies_bitstring)
        if(antibodies_bitstring(i) == '1' || antibodies_bitstring(i) == '0')
            antibodies_intialPop(j) = antibodies_bitstring(i);
            j = j + 1;
        end
    end
    antibodies_intialPop = strtrim(antibodies_intialPop);

    %---- CHECK THE FEASIBLITY OF ANTIBODY
    %--------------------------------------------------------------------------
    %--- Spliting bitstring
    sensNo_str = antibodies_intialPop(1:6);
    sensRange_str = antibodies_intialPop(7:15);
    sensSpan_str = antibodies_intialPop(16:24);
    wheelModel_str = antibodies_intialPop(25:27);
    controlType_str = antibodies_intialPop(28:29);
    planAlgo_str = antibodies_intialPop(30:32);
    
    %--- Check antibody validity
    sensNo = bin2dec(sensNo_str);
    sensRange = bin2dec(sensRange_str);
    sensSpan = bin2dec(sensSpan_str);
    % check sensor parameters
    if(sensNo <= sesorMax && sensNo >= sensorMin && sensRange <= rangeMax && sensRange >= rangeMin && sensSpan <= spanMax && sensSpan >= spanMin)
        % check wheel model
        if(strcmp(wheelModel_str, '001') || strcmp(wheelModel_str, '010')...
                || strcmp(wheelModel_str, '011') || strcmp(wheelModel_str, '100')...
                || strcmp(wheelModel_str, '101'))
            % check control type
            if (strcmp(controlType_str, '01') || strcmp(controlType_str, '10'))
                % check plan algo type
                if(strcmp(planAlgo_str, '001')||strcmp(planAlgo_str, '010'))...
                        %||strcmp(planAlgo_str, '011'));
                    if(strcmp(planAlgo_str, '001') && RINcount<RINab)
                        antibodies(k, :) = antibodies_intialPop;
                        %antibodies(k, 16:24) = '101101000'; % 360 span
                        RINcount = RINcount + 1;
                    elseif (strcmp(planAlgo_str, '001') && SSHTcount<SSHTab)
                        antibodies(k, :) = antibodies_intialPop;
                        SSHTcount = SSHTcount + 1;
                    else 
                        antibodies(k, :) = antibodies_intialPop;
                    end
%                         antibodies(k, 1:24) = '100100001100100010110100'; % 36 sense, 100 range, 180 span
%                         %antibodies(k, 1:24) = '110000001100100101101000'; % 48 sense, 100 range, 360 span
                    k = k+1;
                    if(k == noOfAb+1)
                        break;
                    end
                end
            end
        end
    end
end

end