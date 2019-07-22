function [potentialField, maxVal] = formEquiPotentialLines(arrena, goal)
%formEquiPotentialLines forms the equipotential lines for given arrena.
%   Detailed explanation goes here


% evaluating centriod of the given goal
GCx = round(goal(1, 2) + goal(1, 4)/2);
GCy = round(goal(1, 3) + goal(1, 5)/2);


[m, n] = size(arrena);
potentialField = zeros(m, n);

for i = 1:m
    for j = 1:n
        potentialField(i, j) = round(sqrt((j-GCx)^2 + (i-GCy)^2));
    end
end

maxVal = max(max(potentialField));
potentialField = maxVal - potentialField;

end

