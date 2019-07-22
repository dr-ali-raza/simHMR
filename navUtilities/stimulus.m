function dot_Ai = stimulus(t, Ai) % (for RIN)
%stimulus: Function for solving the stimulus of everybody (using ode45 solver)
%   dy = dot_Ai -> derivative of stimulus of antibodies
%   y  = Ai(t)      -> stimulus of antibodies

global Nab affinity deathRate th sensorOut

antibodies = th;
% antibodies = sensorOut(6,:);

res_mat = [];

for i = 1:Nab
    ai(i, 1) = 1/(1+exp(0.5-Ai(i)));
end

for i = 1:Nab
    sum = 0;
    for j = 1:Nab
        val = cos(antibodies(i)-antibodies(j))*ai(j);
        sum = sum + val;
    end
    res = sum + affinity(i) - deathRate(i);
    res_mat = [res_mat; res];
end

dot_Ai = res_mat.*ai;

end