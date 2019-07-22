function [mags] = mij(dist_o,sDep)
    cij = abs(dist_o-sDep);
    a=sDep;
    b=1;
    %so that a-b*sDep = 0
    mags = zeros([1 length(dist_o)]);
    for k=1:length(dist_o)
       mags(k) = (1^2)*(a-b*dist_o(k)); 
    end
end