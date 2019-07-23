%% Horizontal Line Trajectory:
% The robot follows a horizontal trajectory

clear; close all
addpath('controlUtilities')

opt=odeset('RelTol',1e-2);
ang=[0.00000001,pi/2,pi];
[t, q] = ode45(@horiz_line_posture, [0 2], [0.2 -1 ang(1)],opt);
figure(1)
X_R=t; 
Y_R=0*t; 
plot(X_R,Y_R,'r');
hold all
for i=1:3
[t, q] = ode45(@horiz_line_posture, [0 2], [0.2 -1 ang(i)],opt);
figure(1)
plot(q(:,1),q(:,2),'--');
legend('reference','initial posture angle =0','initial posture angle =pi/2','initial posture angle =pi')
    X       =q(:,1);
    Y       =q(:,2);
    theta   =q(:,3);
xlabel('x-axis');
ylabel('y-axis');
title('Comparison of way adopted to reach a reference point when left with different angles')
figure;    
P = 0.03*[-1 -1 1 1 ; -2 1 1 -2];
for k=1:round(length(t)/20):length(t)
    theta(k)=theta(k)+3*pi/2;
    h = plot(X(k),Y(k),'.','Markersize', 15); 
    axis equal; 
    hold on; 
    w2x=X(k)-0.05*-sin(theta(k));
    w2y=Y(k)-0.05*cos(theta(k));
    plot([w2x,w2x+0.05*cos(theta(k))],[w2y,w2y+0.05*sin(theta(k))],'linewidth',4)
    w3x=w2x-0.05*cos(theta(k));
    w3y=w2y-0.05*sin(theta(k));
    plot([w3x,w3x+0.05*cos(theta(k))],[w3y,w3y+0.05*sin(theta(k))],'linewidth',4)
    plot(X_R, Y_R,'-r'); plot(X,Y,':') 
    R = [ cos(theta(k)) -sin(theta(k)); sin(theta(k)) cos(theta(k))]; % rotation matrix to rotate car. 
    Prot = R*P; %rotated car 
    Prot_trasl = Prot + [ones(1,4)*X(k); ones(1,4)*Y(k)]; % add offset of car's center 
    patch(Prot_trasl(1,:),Prot_trasl(2,:),[0.5 0.5 0.5]); 
    plot(X(k),Y(k),'.','Markersize', 15); 
    set(h,'EraseMode','xor'); 
    pause(0.2)
end
xlabel('x-axis');
ylabel('y-axis');
title('Car Robot following a Horizontal Line Trajectory')
fName = strcat('f4',num2str(i));
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperSize = [6.5 4.5];
fig.PaperPosition = [0 0 6.5 4.5];
fig.PaperPositionMode = 'manual';
print(fName,'-dpdf','-r0')
end