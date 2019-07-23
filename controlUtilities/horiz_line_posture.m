%% Horizontal Line Trajectory:
function [X_dot] = horiz_line_posture(t, q)
  X_R=t; 
  Y_R=0; 
  DX_R=1;
  DY_R=0;
  D2X_R=0;
  D2Y_R=0;
  theta_d=atan2(DY_R,DX_R);
  x=q(1);
  y=q(2);
  theta=q(3); 
  Vd=sqrt(DX_R^2+DY_R^2);
  w_d=(D2Y_R*DX_R-D2X_R*DY_R)/Vd^2;
  K2=70*Vd;
  K1=2*0.7*sqrt(w_d^2+K2*Vd^2);
  K3=K1;
  v  = Vd*cos(theta_d-theta)+ K1*((X_R-x)*cos(theta)+(Y_R-y)*sin(theta));
  w = w_d + K2*Vd*(sin(theta_d-theta)/(theta_d-theta))*((Y_R-y)*cos(theta)-(X_R-x)*sin(theta)) +K3*(theta_d-theta);
  % w = w_d + K2*sign(Vd)*((Y_R-y)*cos(theta)-(X_R-x)*sin(theta))    +K3*(theta_d-theta);
  x_dot     =v*cos(theta);
  y_dot     =v*sin(theta);
  theta_dot =w;
  X_dot=[x_dot; y_dot; theta_dot];
end