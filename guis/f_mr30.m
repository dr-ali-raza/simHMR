function [xdot1] = f_mr30(t,q)
global rad course alpha beta gamma kappa thT EE


 posn            = [alpha beta gamma];
 sDep            = 250;
 sSpan           = 2*pi/3;
 sBinStr_l       = 16;
 esLocX      = 150;            % Energy Source location
esLocY      = 450;
maxEnergy   = 3000;
energy      = maxEnergy;
negR        = 0;
thT         = 1;
[ES] = energySource(esLocX,esLocY);
    
 [sBinStr_o sBinStr_t dist_o th th_g dist_t] = sensorModule1(posn, rad, course, sDep, sSpan, sBinStr_l);
 [F_th1 F_th2 f_OA f_OA_fltd f_GS f_GS_fltd f_GS1 f_GS1_fltd] = objFn_Heading(th, th_g, dist_o, sBinStr_l, sDep, dist_t);
 
 [thC thT] = max(F_th1);
  theta = (th(thT));
  
  
    [EE negR kappa] = energyFa(posn, sBinStr_l, sBinStr_o, sBinStr_t, dist_o, sDep, energy, ES, negR, maxEnergy);  
    
  rho1 = 150;%
  [prx pry] = pol2cart(theta,rho1);
     
  posn = [posn(1)+prx posn(2)+pry theta];
     
  r1=posn(1);
  r2=posn(2);


c   =0.5;           %c=r/2*b
b   =14;            %The distance between a driving wheel and the axis of symmetry of robot 
d   =3.5;           %Distance between the intersection of axis of symmetry with driving wheel axis 
                    %and the centre of mass of robot body
Kp =2000;           % PrOportional constant
Kd  =500;           %Derivative constant

Xc      = q(1);     % X position of Robot's center of mass 
Yc      = q(2);     % Y position of Robot's center of mass
phi     = q(3);     % Robot's Orientation w.r.t x-axis
thR     = q(4);     % Right wheel's angular displacement
thL     = q(5);     % Left wheel's angular displacement
dthR    = q(6);     % Right wheel's angular velocity
dthL    = q(7);     % Left wheel's angular velocity
x_d = r1;           %Desired position of x
y_d = r2;           %Desired position of y
xy_d =[x_d; y_d];
dxy_d = [1; 1];     %Derivative of desired x and y
ddxy_d = [0; 0];    %Double Derivative of desired x and y

Xr = Xc; 
Yr = Yc;
xy = [Xr;Yr];

S = [c*(b*cos(phi)-d*sin(phi)) c*(b*cos(phi)+d*sin(phi)); 
     c*(b*sin(phi)+d*cos(phi)) c*(b*sin(phi)-d*cos(phi));c -c;1 0;0 1]; 
phi_11 = c*(b*cos(phi)-d*sin(phi));
phi_12 = c*(b*cos(phi)+d*sin(phi));
phi_21 = c*(b*sin(phi)+d*cos(phi));
phi_22 = c*(b*sin(phi)-d*cos(phi));
f_phi = [phi_11 phi_12;phi_21 phi_22 ]; %2*2;
nu = [dthR;dthL];
dphi_11 = c*(-b*sin(phi)-d*cos(phi));
dphi_12 = c*(-b*sin(phi)+d*cos(phi));
dphi_21 = c*(b*cos(phi)-d*sin(phi));
dphi_22 = c*(b*cos(phi)+d*sin(phi));
df_phi =[dphi_11 dphi_12;dphi_21 dphi_22];      % Derivative of f_phi
xy_dot  = f_phi*nu;
xy2_dot = ddxy_d+Kd*(dxy_d - xy_dot)+Kp*(xy_d - xy);%PD control to minimize the error between the actual and desired position
U = inv(f_phi)*(xy2_dot-df_phi*nu); 

% System equations
f1 = S*nu;
xdot1 = [f1(1);f1(2);f1(3);f1(4);f1(5); 0; 0] + [0 0;0 0;0 0;0 0;0 0;1 0;0 1]*[U(1);U(2)];

