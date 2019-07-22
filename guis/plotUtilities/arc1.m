
% ========================================================================

function arc1(center,theta,radius,span,points,style)

THETA = linspace(theta-span/2,theta+span/2,points);
RHO = ones(1,points)*radius;

[X,Y] = pol2cart(THETA,RHO);

X = X+center(1);
Y = Y+center(2);

plot(X,Y,style); 