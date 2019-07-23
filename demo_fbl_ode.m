%% Dynamic Feedback Linearization:
% The robot follows a circular trajectory.

clear; close all
addpath('controlUtilities')

t=0;
X_R=0.5*sin(t);
Y_R=0.5*cos(t);
DX_R=0.5*cos(t);
DY_R=-0.5*sin(t);
D2X_R=-0.5*sin(t);
D2Y_R=-0.5*cos(t);

Vd = sqrt((DX_R)^2+(DY_R)^2)
w_d = ((D2Y_R*DX_R)-(D2X_R*DY_R))/Vd;
opt=odeset('RelTol',1e-2);
[t, q] = ode45(@syst, [0 2*pi], [0.4 0.6 0.5 -0.5],opt)
X  =q(:,1);
Y  =q(:,2);
Vd =q(:,3);
phi=q(:,4);
for k = 1:length(t)
    X_R(k)=0.5*sin(t(k));
    Y_R(k)=0.5*cos(t(k));
end
%  plot(t,q);

% Car Graphics
a = [-1 -1]';
b = [2 0]';
c = [-1 1]';
P = 0.03*[-1 -1 1 1 ; -2 1 1 -2]; %matrix with points of vertices to patch car
for k=1:length(t)
    h = plot(X(k),Y(k),'.','Markersize', 15);
    axis equal; axis([-1 1 -0.6 0.6]);
    hold on;
    w2x=X(k)-0.05*-sin(phi(k));
    w2y=Y(k)-0.05*cos(phi(k));
    plot([w2x,w2x+0.05*cos(phi(k))],[w2y,w2y+0.05*sin(phi(k))],'linewidth',4)
    w3x=w2x-0.05*cos(phi(k));
    w3y=w2y-0.05*sin(phi(k));
    plot([w3x,w3x+0.05*cos(phi(k))],[w3y,w3y+0.05*sin(phi(k))],'linewidth',4)
    plot(X_R(2:k), Y_R(2:k),'-r'); plot(X(2:k),Y(2:k),':')
    R = [ cos(phi(k)) -sin(phi(k)); sin(phi(k)) cos(phi(k))]; % rotation matrix to rotate car.
    Prot = R*P; %rotated car
    Prot_trasl = Prot + [ones(1,4)*X(k); ones(1,4)*Y(k)]; % add offset of car's center
    patch(Prot_trasl(1,:),Prot_trasl(2,:),[0.5 0.5 0.5]);
    plot(X(k),Y(k),'.','Markersize', 15);
    hold off;
    set(h,'EraseMode','xor');
    pause(0.1);
end
xlabel('x-axis');
ylabel('y-axis');
title('Circular Trajectory tracking using Dynamic Feedback Linearization')
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperSize = [6.5 4.5];
fig.PaperPosition = [0 0 6.5 4.5];
fig.PaperPositionMode = 'manual';
print('f5','-dpdf','-r0')
EX = X_R-X'
EY = Y_R-Y'
ERR = sqrt(EX.^2+EY.^2)
%% Plots
figure;
plot(X_R, Y_R,'r','linewidth',2);
hold on; plot(X,Y,'--');
figure; plot(Vd)
xlabel('time')
ylabel('v');
title('Velocity Plot')
figure; plot(phi),
xlabel('time')
ylabel('phi');
title('Angular position of wheels Plot')
figure; plot(EX); hold on; plot(EY,'r');
xlabel('time')
ylabel('Error Plot');
title('Error for tracking using Dynamic Feedback Linearization');
figure; plot(t,ERR,'r');
axis([0 t(end) -0.1 2]);
ylabel('Error');
xlabel('time');
title('Norm of Error for tracking using Dynamic Feedback Linearization');
