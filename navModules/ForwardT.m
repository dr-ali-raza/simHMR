% velo = [1,1,1,1,45,-45,-135,135]; %X-direction
% velo = [1,1,1,1,135,45,-45,-135]; %Y-direction
% velo = [1,1,1,1,135,45,-45,-135]; %X-direction
 velo = [1,1,1,1,90]; %Y-direction
% b1 = velo(5);
% b2 = velo(6);
% b3 = velo(7);
% b4 = velo(8);
b= velo(5);
r = 1; %radius
d = 0; %Caster offset
l = 1;
J1 = [sind(45+b) -cosd(45+b) -cosd(b);
      sind(45+b) -cosd(45+b) -cosd(b-90);
      sind(45+b) -cosd(45+b) -cosd(b+180);
      sind(45+b) -cosd(45+b) -cosd(b+90)];
  
C1 = [cosd(45+b) sind(45+b) (d+l)*sind(b);
      cosd(45+b) sind(45+b) (d+l)*sind(b-90);
      cosd(45+b) sind(45+b) (d+l)*sind(b+180);
      cosd(45+b) sind(45+b) (d+l)*sind(b+90)];

% J1 = [sind(45+b1) -cosd(45+b1) -cosd(b1);
%       sind(135+b2) -cosd(135+b2) -cosd(b2);
%       sind(225+b3) -cosd(225+b3) -cosd(b3);
%       sind(-45+b4) -cosd(-45+b4) -cosd(b4)];
%   
% C1 = [cosd(45+b1) sind(45+b1) (d+l)*sind(b1);
%       cosd(135+b2) sind(135+b2) (d+l)*sind(b2);
%       cosd(225+b3) sind(225+b3) (d+l)*sind(b3);
%       cosd(-45+b4) sind(-45+b4) (d+l)*sind(b4)];

A = [J1;C1];

B = [r 0 0 0 0 0 0 0;
     0 r 0 0 0 0 0 0;
     0 0 r 0 0 0 0 0;
     0 0 0 r 0 0 0 0;
     0 0 0 0 -d 0 0 0;
     0 0 0 0 0 -d 0 0;
     0 0 0 0 0 0 -d 0;
     0 0 0 0 0 0 0 -d];

th = 90;
R = [cosd(th) sind(th) 0; -sind(th) cosd(th) 0; 0 0 1];
etaR = [velo(1); velo(2); velo(3); velo(4); b;b;b;b];
etaI = R*(inv(A'*A)*A'*B*etaR)