function dy = test(t,vI)
global linVelo b;
etaI = Forwardc(linVelo,b);

Rot = [cosd(90) -sind(90) 0; sind(90) cosd(90) 0; 0 0 1];
etaS = Rot*etaI;

dy = etaS;