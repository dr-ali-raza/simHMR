%% Tracking of a reference vehicle with same kinematics
% The problem of tracking of a reference vehicle is examined,
% in both position and orientation.
% The smooth time functions are solution to the robot’s kinematic model
% for some specific control input, known as the reference control.

clear; close all
addpath('controlUtilities')

opt=odeset('RelTol',1e-0);
[t, q] = ode45(@ref_IP_1, [0 30], [1,1,0,-1, -1,0],opt);
figure(1)
eX        =q(:,4);
eY        =q(:,5);
e_theta   =q(:,6);
X_r       =q(:,1);
Y_r       =q(:,2);
theta_r   =q(:,3);
X         =X_r-eX;
Y         =Y_r-eY;
theta     =theta_r-e_theta;

P = 5*0.03*[-1 -1 1 1 ; -2 1 1 -2];
for k=1:round(length(t)/50):length(t)
    theta(k)=atan(theta(k))+3*pi/2
    h = plot(X(k),Y(k),'.','Markersize', 15);
    axis equal;
    axis([0 13 -4 4]);
    hold on;
    w2x=X(k)-0.05*-sin(theta(k));
    w2y=Y(k)-0.05*cos(theta(k));
    plot([w2x,w2x+0.05*cos(theta(k))],[w2y,w2y+0.05*sin(theta(k))],'linewidth',4)
    w3x=w2x-0.05*cos(theta(k));
    w3y=w2y-0.05*sin(theta(k));
    xlabel('x-axis');
    ylabel('y-axis');
    title('Robot tracking aother vehicle')
    %% Plots
    plot([w3x,w3x+0.05*cos(theta(k))],[w3y,w3y+0.05*sin(theta(k))],'linewidth',4)
    plot(X_r,Y_r,'r','linewidth',2)
    plot(X,Y,'b--')
    plot(X(1),Y(1),'o')
    R = [ cos(theta(k)) -sin(theta(k)); sin(theta(k)) cos(theta(k))]; % rotation matrix to rotate car.
    Prot = R*P; %rotated car
    Prot_trasl = Prot + [ones(1,4)*X(k); ones(1,4)*Y(k)]; % add offset of car's center
    patch(Prot_trasl(1,:),Prot_trasl(2,:),[0.5 0.5 0.5]);
    plot(X(k),Y(k),'.','Markersize', 15);
    set(h,'EraseMode','xor');
    pause(0.2)
end
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperSize = [6.5 4.5];
fig.PaperPosition = [0 0 6.5 4.5];
fig.PaperPositionMode = 'manual';
print('f3','-dpdf','-r0')