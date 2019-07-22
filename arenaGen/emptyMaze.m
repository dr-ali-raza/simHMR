% Function to generate empty space for maze 
% 
% Written by Ali Raza
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function maze = emptyMaze(X,Y)
conn = zeros(Y*X,4);
maze = struct('conn',conn,'R',Y,'C',X);