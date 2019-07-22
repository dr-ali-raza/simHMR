% Function to plot the instantaneous status of different components of the
% objective function
%
% Written by Ali Raza, (c) 2018
% ali.raza@ymail.com
%
% University of Engineering and Technology
% ========================================================================
function plot_objFn_H1(sensorOut, objFn_H1_out)

F_th1 = objFn_H1_out(1,:);
F_th2 = objFn_H1_out(2,:);
f_OA = objFn_H1_out(3,:);
f_OA_fltd = objFn_H1_out(4,:);
f_GS = objFn_H1_out(5,:);
f_GS_fltd = objFn_H1_out(6,:);
f_GS1 = objFn_H1_out(7,:);
f_GS1_fltd = objFn_H1_out(8,:);

subplot(3,3,1), polar(sensorOut(6,:),f_OA); title('f_{OA}');
subplot(3,3,2), polar(sensorOut(6,:),f_OA_fltd);title('f_{OA} filtered');
subplot(3,3,3), polar(sensorOut(6,:),f_GS);title('f_{GS}');
subplot(3,3,4), polar(sensorOut(6,:),f_GS_fltd);title('f_{GS} filtered');
subplot(3,3,5), polar(sensorOut(6,:),f_GS1);title('f_{GS1}');
subplot(3,3,6), polar(sensorOut(6,:),f_GS1_fltd);title('f_{GS1} filtered');
subplot(3,3,7), polar(sensorOut(6,:),sensorOut(3,:));title('Distance');
subplot(3,3,8), polar(sensorOut(6,:),F_th1);title('F - sum');
subplot(3,3,9), polar(sensorOut(6,:),F_th2);title('F - product');