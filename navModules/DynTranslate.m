function phiV = DynTranslate()
[t,y] = ode45(@diff_DynTrans,[0 1],[0 0 0 0]);
phiV = 50.* y(end,1);