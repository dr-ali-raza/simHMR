[t,y] = ode45(@test, linspace(0,10,500),[1,1,0]);
plot(t,y(:,1),t,y(:,2),t,y(:,3))