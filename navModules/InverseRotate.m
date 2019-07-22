function phiV = InverseRotate(thR)
global b;
b1 = b; b2 = b-90; b3 = b+180; b4 = b+90;

%x = 400;
%y=400;
r = 1; %radius
d = 0; %Caster offset
l = 1;
% J1 = [sind(45+b) -cosd(45+b) -cosd(b);
%       sind(45+b) -cosd(45+b) -cosd(b-90);
%       sind(45+b) -cosd(45+b) -cosd(b+180);
%       sind(45+b) -cosd(45+b) -cosd(b+90)];
%   
% C1 = [cosd(45+b) sind(45+b) (d+l)*sind(b);
%       cosd(45+b) sind(45+b) (d+l)*sind(b-90);
%       cosd(45+b) sind(45+b) (d+l)*sind(b+180);
%       cosd(45+b) sind(45+b) (d+l)*sind(b+90)];

J1 = [sind(45+b1) -cosd(45+b1) -cosd(b1);
      sind(135+b2) -cosd(135+b2) -cosd(b2);
      sind(225+b3) -cosd(225+b3) -cosd(b3);
      sind(-45+b4) -cosd(-45+b4) -cosd(b4)];
  
C1 = [cosd(45+b1) sind(45+b1) (d+l)*sind(b1);
      cosd(135+b2) sind(135+b2) (d+l)*sind(b2);
      cosd(225+b3) sind(225+b3) (d+l)*sind(b3);
      cosd(-45+b4) sind(-45+b4) (d+l)*sind(b4)];

A = [J1;C1];

B = [r 0 0 0;
     0 r 0 0;
     0 0 r 0;
     0 0 0 r;
     0 0 0 0;
     0 0 0 0;
     0 0 0 0;
     0 0 0 0];

% th = 90;
%R = [cosd(th) -sind(th) 0; sind(th) cosd(th) 0; 0 0 1];
etaI = [0;0;thR];
phiV = (psuedoinv(B)*A*etaI)