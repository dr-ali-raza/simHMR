function [theta] = VFH(posn,dist_o,th,sDep,target,sSpan)
    %============================
    Xt = target(2)+(target(4)/2);
    Yt = target(3)+(target(5)/2);
    tar = [Xt, Yt];
    % calculating the obstcale vectors
    [obstacle_agles] = Bij(dist_o,th,sDep);                                  %Direction form active cell to VCP
    [obstacle_mags] = mij(dist_o,sDep);                                      %Magnitude of abstacle vector
%     for k=1:length(dist_o)
%         [X,Y] = pol2cart(obstacle_agles(k),obstacle_mags(k));
%         plot([posn(1) posn(1)+X],[posn(2) posn(2)+Y],'b');
%     end
    sector_width_alpha = 10;
    no_sectors = rad2deg(sSpan)/sector_width_alpha;
    no_of_sensors_per_sector = length(dist_o)/no_sectors;
    new_obs_mags = reshape(obstacle_mags,[no_of_sensors_per_sector, no_sectors]);   
    hk = sum(new_obs_mags);
    angle_to_hk = sector_width_alpha/2;
    angles_new = [angle_to_hk:sector_width_alpha:rad2deg(sSpan)];
%   position_to_start = find(abs(th)==min(abs(th)));
    avg_ang=zeros(1,no_sectors);
    loop=1;
    for k=1:no_of_sensors_per_sector:length(dist_o)
        avg_ang(loop)=(th(k)+th(k+1))/2;
        loop=loop+1;
    end
    angles_to_go = avg_ang;
    new_hk = [hk hk hk];
    loop=length(hk)+1;
    for k=1:length(hk)
        hk_dash(k) = (new_hk(loop-1)+2*new_hk(loop)+new_hk(loop+1))/(2*2+1);
        loop=loop+1;
    end
    %for k=1:length(angles_to_go)
     %   [X,Y] = pol2cart(angles_to_go(k),hk_dash(k));
      %  plot([posn(1) posn(1)+X],[posn(2) posn(2)+Y],'b');
%end
    %=================================================
    % steering direction of robot.......
    [T, M] = cart2pol(tar(1)-posn(1),tar(2)-posn(2));
    kt = T;
    
    input_angles = kt;
    for k=1:length(input_angles)
       [x y] = pol2cart(input_angles(k),10);
       [ang mag] = cart2pol(x,y);
       pos_angles(k) = ang;
       if(pos_angles(k)<0)
          pos_angles(k) = pos_angles(k)+(2*pi); 
       end
    end
    kt = pos_angles;                                                        %Target sector
    
    target_angle_diffs = angles_to_go-kt;
    
    input_angles = target_angle_diffs;
    for k=1:length(input_angles)
       [x y] = pol2cart(input_angles(k),10);
       [ang mag] = cart2pol(x,y);
       pos_angles(k) = ang;
       if(pos_angles(k)<0)
          pos_angles(k) = pos_angles(k)+(2*pi); 
       end
    end
    target_angle_diffs = pos_angles;
    
    new_target_angle_diffs = (2*pi)-target_angle_diffs;
    
    input_angles = new_target_angle_diffs;
    for k=1:length(input_angles)
       [x y] = pol2cart(input_angles(k),10);
       [ang mag] = cart2pol(x,y);
       pos_angles(k) = ang;
       if(pos_angles(k)<0)
          pos_angles(k) = pos_angles(k)+(2*pi); 
       end
    end
    new_target_angle_diffs = pos_angles;
    
    new_target_angle_diffs = abs(new_target_angle_diffs);
    for k=1:length(target_angle_diffs)
        if target_angle_diffs(k) <= new_target_angle_diffs(k)
            ttt(k) = target_angle_diffs(k);
        else
            ttt(k) = new_target_angle_diffs(k);
        end
    end
    target_angle_diffs = ttt;
    
    input_angles = target_angle_diffs;
    for k=1:length(input_angles)
       [x y] = pol2cart(input_angles(k),10);
       [ang mag] = cart2pol(x,y);
       pos_angles(k) = ang;
       if(pos_angles(k)<0)
          pos_angles(k) = pos_angles(k)+(2*pi); 
       end
    end
    target_angle_diffs = pos_angles;
    
    sector_of_target = find(abs(target_angle_diffs)==min(abs(target_angle_diffs)));
    threshold_value = 10;
    for k=1:length(hk_dash)
       if hk_dash(k)<10
         sector_below_threshold(k) = k; 
       else
         sector_below_threshold(k) = 0; 
       end
    end
    closest_sector = sector_below_threshold-sector_of_target;
    indexss = find(closest_sector==min(closest_sector));
    closest_sector(indexss)=Inf;
    kn = find(abs(closest_sector)==min(abs(closest_sector)));
    kn = kn(1);
    kf=kn;
    kf=kf+length(sector_below_threshold);
    s_kf = kf;
    new_sector_below_threshold = [sector_below_threshold,sector_below_threshold,sector_below_threshold];
    if new_sector_below_threshold(kf+1)==0
        while new_sector_below_threshold(kf)~=0
          kf = kf-1;
        end
        kf=kf+1;
    elseif new_sector_below_threshold(kf-1)==0
        while new_sector_below_threshold(kf)~=0
          kf = kf+1;
        end
        kf=kf-1;
    end
    kf = kf;
    kf = new_sector_below_threshold(kf);
    kf = kf(1);
    if kf>36
        kf=kf-length(sector_below_threshold);
    end
    avg_k = (kn+kf)/2;
    r_avg_k = round(avg_k);
    theta = angles_to_go(r_avg_k);
    d_theta = rad2deg(theta);
    %[X,Y] = pol2cart(theta,100);
    %plot([posn(1) posn(1)+X],[posn(2) posn(2)+Y],'r');
    
    %============================
end