function bitwiseMap = bitwiseMapArrenaforObstacles(arrena, obsWeight)
%bitwiseMapArrenaforObstacles Maps obstacles present in arrena
%   Detailed explanation goes here

threshold = 50;

[m, n] = size(arrena);
bitwiseMap = zeros(m, n);

for i = 1:m
    for j = 1:n
        if arrena(i, j)<threshold
            bitwiseMap(i, j) = -obsWeight;
        end
    end
end

end

