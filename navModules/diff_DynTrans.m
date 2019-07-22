function dydt = diff_DynTrans(t,q)
global b phiV xR yR;
r=1;
m = 5;
mw = 0.4;
Iw = 0.02;
B = [0;0;4];
S = [r*cosd(b+135); r*sind(b+135); 1];
M = S'*[m+4*mw 0 0;0 m+4*mw 0;0 0 4*Iw]*S;
f2 = inv(S'*M*S)*(-S'*M*S*phiV(1));
u = sqrt((xR.^2+yR.^2));
T = pinv(inv(S'*M*S)*S'*B)*(u-f2);

qdot2 = [q(4); B*T/M];
dydt = qdot2;