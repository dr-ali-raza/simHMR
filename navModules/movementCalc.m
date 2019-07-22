function [th,rho] = movementCalc(phiV,b)
b_R = (b-135)/180*pi;
r = 1; %Wheel Radius
cartx = 0;
carty = 0;
for i = 1:length(phiV)
    [tempx,tempy] = pol2cart(b_R,abs(r*phiV(i)));
    cartx = tempx+cartx;
    carty = tempy+carty;
end
[th,rho] = cart2pol(cartx,carty);