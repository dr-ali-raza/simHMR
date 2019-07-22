% Function to simulate sensor arrangement on a robot
%
% Can be used for two arrangments
% 1. sonar/ultrasonic sensor sweeping across a span (C_span)
% 2. A number of photosensors on robot's periphery (C_Binstr_l)
%
% Also uses a grayscale image for computation
%
% Written by Ali Raza, (c) 2018
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function [sensorOut] = sensorModule(posn, rad, course, course1, C_dep, C_span, C_BinStr_l)
global tag1
[dimy, dimx]    = size(course);
th_inc          = posn(3)- C_span/2;

sizeFactor      = length(1:C_BinStr_l);
sensorOut       = zeros(8,sizeFactor);
sensorOut(1:2,:)= ones(2,sizeFactor);
sensorOut(3:4,:)= C_dep*ones(2,sizeFactor);

% sensorOut(1,:)      = ones(sizeFactor);         % sensorOut(1,:), assumes no obstacle in front (white)
% sensorOut(2,:)      = ones(sizeFactor);         % sensorOut(2,:), assumes no target in front (white)
% sensorOut(3,:)      = C_dep*ones(sizeFactor);   % sensorOut(3,:)
% sensorOut(4,:)      = C_dep*ones(sizeFactor);   % sensorOut(4,:)
% sensorOut(5,:)      = 0.2*zeros(sizeFactor);    % sensorOut(5,:)
% sensorOut(6,:)      = zeros(sizeFactor);        % sensorOut(6,:)
% sensorOut(7,:)      = zeros(sizeFactor);        % sensorOut(7,:)
% sensorOut(8,:)      = zeros(sizeFactor);        % sensorOut(8,:)

for j = 1:C_BinStr_l
    Tin = 0;
    Oin = 0;
    for i = rad:(rad + C_dep)
        posn33      = th_inc;
        x           = posn(2)+ i*sin(posn33);
%         pause
        y           = posn(1)+ i*cos(posn33);
%         x(x < 20)         = 20;
%         x(x > dimx-20)    = dimx-20;
%         y(y < 20)         = 20;
%         y(y > dimy-20)    = dimy-20;
%         x(x < 2)         = 2;
%         x(x > dimx-2)    = dimx-2;
%         y(y < 2)         = 2;
%         y(y > dimy-2)    = dimy-2;
    if(course1(round(x),round(y)) == 0)      % Obstacle (Black = 0)
            sensorOut(1,j) = 0;
            sensorOut(8,j) = th_inc;
            sensorOut(3,j) = i;
            sensorOut(4,j) = 0;
            Oin = 1;
        end
        if (course(round(x),round(y)) == 76)    % Target (red->grey =76)
            sensorOut(2,j)   = 0;
            sensorOut(7,j) = th_inc;
%             sensorOut(5,j)= 1;
            sensorOut(5,j)= i;            
            Tin = 1;
        end
        % if (sensorOut(2,j)== 0)|(sensorOut(1,j)==0)
        if (Tin ~= 0) || (Oin ~= 0)
            break
        end
    end
    sensorOut(6,j) = th_inc;
    [x1, y1] = pol2cart(th_inc,i);
    th_inc  = th_inc + C_span/C_BinStr_l;
    posn    = [posn(1) posn(2) posn33];
    % ===================================================================
    % Uncomment following section to plot the scan
    if tag1 == 0
        a2 = [posn(1), posn(1)+x1];
        b2 = [posn(2), posn(2)+y1];
        plot(a2,b2,'g:')
        drawnow;
        % pause(0.1);
    end
    % ===================================================================
end
tag1 = 1;