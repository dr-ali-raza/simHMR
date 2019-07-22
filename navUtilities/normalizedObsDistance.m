% normalizedObsDistance evaluates the nomalized obstacle distance based on 
% fuzzy logic with (for RIN)
%           d = 1 for dangerous, d = 2 for medium and d => 3 for save
% d = 1 means obstacle is next to wall


function d_norm = normalizedObsDistance(o_dist)

d_norm = zeros(1, length(o_dist));
L3 = 0.25; L2 = 0.5; L1 = 1;
s = 100; m = 50; d = 25;

for i = 1:length(o_dist)
    if(o_dist(i)>s)
        mu_s = 1;
        mu_m = 0;
        mu_d = 0;
    elseif(o_dist(i)<=s && o_dist(i)>m)
        mu_s = (o_dist(i)-m)/(s-m);
        mu_m = (o_dist(i)-s)/(m-s);
        mu_d = 0;
    elseif(o_dist(i)<=m && o_dist(i)>d)
        mu_s = 0;
        mu_m = (-o_dist(i)+d)/(d-m);
        mu_d = (-o_dist(i)+m)/(m-d);
    elseif(o_dist(i)<=d)
        mu_s = 0;
        mu_m = 0;
        mu_d = 1;
    end
    
    d_norm(i) = (mu_s*L1+mu_m*L2+mu_d*L3)/(mu_s+mu_m+mu_d);
end