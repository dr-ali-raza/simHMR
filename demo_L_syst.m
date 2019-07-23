%% linear feedback controller
% A different initial point is assigned and linear feedback controller
% is used which also provides a solution for posture stabilization

clear; close all
addpath('controlUtilities')

opt=odeset('RelTol',1e-2);
[t, q] = ode45(@L_syst, [0 8*pi], [2 1 pi],opt);
X_R=0.5*sin(t);
Y_R=0.5*cos(t);
plot(X_R,Y_R,'r');
hold on
plot(q(:,1),q(:,2));
X = q(:,1);
Y = q(:,2);
theta = q(:,3);
figure;
plot(t,q);
figure;
% Car Grphics
b = [-1 -1]';
a = [2 0]';
c = [-1 1]';
P = 0.03*[-1 -1 1 1 ; -2 1 1 -2]; %matrix with points of vertices to patch car
for k=1:length(t)
    theta(k)=theta(k)+pi/2
    h = plot(X(k),Y(k),'.','Markersize', 15);
    axis equal;
    hold on;
    w2x=X(k)-0.05*-sin(theta(k));
    w2y=Y(k)-0.05*cos(theta(k));
    plot([w2x,w2x+0.05*cos(theta(k))],[w2y,w2y+0.05*sin(theta(k))],'linewidth',4)
    w3x=w2x-0.05*cos(theta(k));
    w3y=w2y-0.05*sin(theta(k));
    plot([w3x,w3x+0.05*cos(theta(k))],[w3y,w3y+0.05*sin(theta(k))],'linewidth',4)
    plot(X_R(2:k), Y_R(2:k),'-r'); plot(X(2:k),Y(2:k),':')
    R = [ cos(theta(k)) -sin(theta(k)); sin(theta(k)) cos(theta(k))]; % rotation matrix to rotate car.
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
title('Circular trajectory following of Robot using linear feedback controller')
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperSize = [6.5 4.5];
fig.PaperPosition = [0 0 6.5 4.5];
fig.PaperPositionMode = 'manual';
print('f1','-dpdf','-r0')
EX = X_R-X
EY = Y_R-Y
ERR = sqrt(EX.^2+EY.^2)
length(ERR)
length(t)

%% Plots
figure; plot(theta),
xlabel('time')
ylabel('theta');
title('Angular position of wheels Plot')
figure; plot(EX); hold on; plot(EY,'r');
xlabel('time')
ylabel('Error Plot');
title('Error Plot')
figure; plot(t,ERR,'r');
axis([0 t(end) -0.1 2]);
ylabel('Error');
xlabel('time');
