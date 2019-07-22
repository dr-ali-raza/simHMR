function etaI = ForwardRotate(velo)
b1 = 45; b2 = 45; b3 = 45; b4 = 45;
r = 1; %radius
d = 0; %Caster offset
l = 1;

J1 = [sind(45+b1) -cosd(45+b1) -cosd(b1);
      sind(135+b2) -cosd(135+b2) -cosd(b2);
      sind(225+b3) -cosd(225+b3) -cosd(b3);
      sind(-45+b4) -cosd(-45+b4) -cosd(b4)];
  
C1 = [cosd(45+b1) sind(45+b1) (d+l)*sind(b1);
      cosd(135+b2) sind(135+b2) (d+l)*sind(b2);
      cosd(225+b3) sind(225+b3) (d+l)*sind(b3);
      cosd(-45+b4) sind(-45+b4) (d+l)*sind(b4)];

A = [J1;C1];

B = [r 0 0 0 0 0 0 0;
     0 r 0 0 0 0 0 0;
     0 0 r 0 0 0 0 0;
     0 0 0 r 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0];

phiV = [velo;velo;velo;velo;0; 0; 0; 0];
etaI = (inv(A'*A)*A'*B*phiV);