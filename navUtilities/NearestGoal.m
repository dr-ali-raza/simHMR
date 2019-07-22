function goalVector = NearestGoal(cPosn, goalMatrix)
%NearestGoal Summary of this function goes here
%   Detailed explanation goes here

noOfGoals = size(goalMatrix, 1);
goalDistances = zeros(1, noOfGoals);

for i = 1:noOfGoals
    cGoal = goalMatrix(i, :);
    xGoal = cGoal(2) + cGoal(4)/2;
    yGoal = cGoal(3) + cGoal(5)/2;
    goalDistances(i)= sqrt((yGoal-cPosn(2))^2+(xGoal-cPosn(1))^2);
end

[m, n] = min(goalDistances);
goalVector = goalMatrix(n, :);

end

