%% Tracking of a reference vehicle with same kinematics

function [X_dot] = ref_IP_1(t, q)

  X_R=q(1);
  Y_R=q(2);
  theta_r=q(3);
if t<10
      u=[1;0];
else if t>10 && t<=18
      u=[-1,-0.5*cos(2*pi*(t-10)/5)];
else if t>18
      u=[1;0];
      theta_r=0;
     end
     end
end
  u1r=u(1);
  u2r=u(2);   
  DX_R=u1r*cos(theta_r);
  DY_R=u1r*sin(theta_r);
  D_theta_r=u2r;
  D2X_R=0;
  D2Y_R=0;
  x=q(4);
  y=q(5);
  theta=q(6); 
  
K1=3;
K2=1;
K3=1;
w1=-K1*abs(u1r)*(x+y*theta);
w2=-K2*u1r*y-K3*abs(u1r)*theta;
ex_dot=u2r*y+w1;
ey_dot=-u2r*x+u1r*theta+w1*theta;
e_theta_dot=w2;

X_dot=[DX_R;DY_R;D_theta_r;ex_dot; ey_dot; e_theta_dot];
end