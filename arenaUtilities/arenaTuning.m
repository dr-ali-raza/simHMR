
%arenaTuning tunes the image after using 'imresize' function of MATLAB.
% Written by Shujat Ali ,mshujatali@gmail.com
%
% University of Engineering and Technology, Lahore
% =========================================================================
% 'imresize' induces extra gray pixels around obstacles and goals. This
% function will remove all those pixels.
% -------------------------------------------------------------------------
% Input Variable:
%   inputArena: contains an gray scale image with values:
%               255 = empty space; 0 = obstacle/wall; some value(0-255)= goal
%               Image also contains values (considered as noise) other than
%               these three levels. These values need to be removed
%
% Output Variable:
%   outputArena: contains an gray scale image with only three specified
%                levels
% =========================================================================

function [ outputArena] = arenaTuning(inputArena)

outputArena = inputArena;
[m, n] = size(outputArena);

free = 255; % cell value for free space
wall = 0;   % cell value for wall\obstacle
goal = 76;  % cell value for goal

for i=1:m
    for j = 1:n
        curCell = outputArena(i, j);
        if(curCell ~= free && curCell ~= wall && curCell ~= goal)
            outputArena(i, j) = free;
        end
    end
end
        
end

