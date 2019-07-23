% Mobile Robot platform with linear feedback controller

function [X_dot] = L_syst(t, q)
  X_R=0.5*sin(t); 
  Y_R=0.5*cos(t); 
  DX_R=0.5*cos(t);
  DY_R=-0.5*sin(t);
  D2X_R=-0.5*sin(t);
  D2Y_R=-0.5*cos(t);
  theta_d=atan2(DY_R,DX_R);
  x=q(1);
  y=q(2);
  theta=q(3); 
  Vd=sqrt(DX_R^2+DY_R^2);
  w_d=(D2Y_R*DX_R-D2X_R*DY_R)/Vd^2;
  K2=7*Vd;
  K1=2*0.99*sqrt(w_d^2+K2*Vd^2);
  K3=K1;
  v = Vd*cos(theta_d-theta)+ K1*((X_R-x)*cos(theta)+(Y_R-y)*sin(theta));
  w = w_d + K2*sign(Vd)*((Y_R-y)*cos(theta)-(X_R-x)*sin(theta))
  x_dot = v*cos(theta);
  y_dot = v*sin(theta);
  theta_dot = w;
  X_dot=[x_dot; y_dot; theta_dot];
  end
