function phiV = DynRotate()
[t,y] = ode45(@diff_DynRot,[0 1],[0 0 0]);
phiV = 50.* y(end,1);