function [angles] = Bij(dist_o,th,sDep)
    indexes = dist_o<sDep;
    angles = zeros([1 length(dist_o)]);
    for k=1:length(dist_o)
        if indexes(k)==0
           angles(k) = 0; 
        else
           angles(k) = th(k);
           angles(k) = angles(k) + pi;
        end
    end
end