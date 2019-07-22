%%
% Synopsis
% rangeFind function gives Obstacle information on the side on which range finder has been activated. 
% If any particular sensor is not activated then it will always give output
% corresponding to no obstacle detected.

% Input:
% N = 4-bit binary string having '1' if corresponding sensor is to be
% activated or '0' if it is deactivated. For example '1101' will activate
% sensor number 1,2, and 4, while deactivate sensor number 3.
% span = the sensor can take readings in the range of +- span/2 degrees 
% dep = depth in pixels in which the sensor can take readings
% res = number of reading directions per degree
% 
% Output:
% D1, D2, D3, D4 = Binary values, '1' corresponds of no obstacle detected,
% while '0' corresponds to obstacle detected respectively for all 4
% sensors.
%
%Written By: Muhammad Rzi Abbas

function [D1, D2, D3, D4] = rangeFind(N,span,dep,res)
global xc yc course ;
%yc = 500; %Column
%xc=300; %Row
D1 = 1; D2 = 1; D3 = 1; D4 = 1;
N = int32(N);
S4 = idivide(N,1000,'floor');
S4_c = [yc,xc-1];
N = N-S4*1000;
S3 = idivide(N,100,'floor');
S3_c = [yc-1,xc];
N = N-S3*100;
S2 = idivide(N,10,'floor');
S2_c = [yc,xc+1];
N = N-S2*10;
S1 = idivide(N,1,'floor');
S1_c = [yc+1,xc];
totAng = linspace(-span/2,span/2,span*res);

if S1 == 1
    D1 = 1;
    for i = 1:length(totAng)
        for d = 1:dep
            itrptr(i,d) = round(S1_c(1)+d*cosd(totAng(i)));
            itrptc(i,d) = round(S1_c(2)+d*sind(totAng(i)));
            scan(i,d) = course(itrptr(i,d),itrptc(i,d));
        end
    end
    if min(min(scan))<255
        D1 = 0;
    end
end

%%
if S2 == 1
    D2 = 1;
    for i = 1:length(totAng)
        for d = 1:dep
            itrptr(i,d) = round(S2_c(1)+d*sind(totAng(i)));
            itrptc(i,d) = round(S2_c(2)+d*cosd(totAng(i)));
            scan(i,d) = course(itrptr(i,d),itrptc(i,d));
        end
    end
    if min(min(scan))<255
        D2 = 0;
    end
end

%
if S3 == 1
    D3 = 1;
    for i = 1:length(totAng)
        for d = 1:dep
            itrptr(i,d) = round(S3_c(1)-d*cosd(totAng(i)));
            itrptc(i,d) = round(S3_c(2)+d*sind(totAng(i)));
            scan(i,d) = course(itrptr(i,d),itrptc(i,d));
        end
    end
    if min(min(scan))<255
        D3 = 0;
    end
end

%%
if S4 == 1
    D4 = 1;
    for i = 1:length(totAng)
        for d = 1:dep
            itrptr(i,d) = round(S4_c(1)+d*sind(totAng(i)));
            itrptc(i,d) = round(S4_c(2)-d*cosd(totAng(i)));
            scan(i,d) = course(itrptr(i,d),itrptc(i,d));
        end
    end
    if min(min(scan))<255
        D4 = 0;
    end
end
 %plot(itrptr',itrptc')