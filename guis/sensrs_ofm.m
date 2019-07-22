function dist_ob=sensrs_ofm(q,course)
[dimy, dimx] = size(course);
r=5;
range=r+20;

for S = r:range
  h=0:0.001:pi/16;
    y = q(1)+ S*cos(h);
    x = q(2)+ S*sin(h);
    %make sure x & y are inside the course
   x(x < 1) = 1;
   x(x > dimx) = dimx;
    y(y < 1) = 1;
    y(y > dimy) = dimy;
    % p=   course(round(x),round(y))
    %see if the course at x & y is an obstacle or not
    if((course(round(x)+60,round(y)+60)==0))
        %if yes, return the distance to the obstacle
        dist_ob = S-r;
        return;
    end
end

%if no obstacles found within 12 pixels, return 12
dist_ob = 20;
   % end
%end
return;
