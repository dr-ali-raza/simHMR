function [X_dot] = syst(t, q)

 X_R=0.5*sin(t); 
 Y_R=0.5*cos(t); 
 DX_R=0.5*cos(t);
 DY_R=-0.5*sin(t);
 D2X_R=-0.5*sin(t);
 D2Y_R=-0.5*cos(t);

 K_p1 = 4; 
 K_p2 = 5; 
 K_v1 = 5; 
 K_v2 = 6; 
%% calculations
 X = q(1); % xc 
 Y = q(2); % yc
 CT = q(3);
 phi = q(4);

% differential drive robot model 
 Vd = CT;
 dx=Vd*-sin(phi);
 dy=Vd*cos(phi);
% errors calculation 
 EX = X_R-X; 
 EY = Y_R-Y;
 ERR = sqrt(EX^2+EY^2); 
% Feedback linearization 
 u1 = D2X_R + K_v1*(DX_R-dx)+K_p1*(EX); 
 u2 = D2Y_R + K_v2*(DY_R-dy)+K_p2*(EY); 
 CT_d=u1*-sin(phi) + u2*cos(phi);
 w_d = (u2*-sin(phi)-u1*cos(phi))/Vd; 
 phi_d=w_d;
 X_dot=[dx,dy,CT_d,phi_d]';   
end