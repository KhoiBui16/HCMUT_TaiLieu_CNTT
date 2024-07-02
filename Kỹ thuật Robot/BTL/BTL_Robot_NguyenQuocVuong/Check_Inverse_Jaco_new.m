function [res, theta_inv] = Check_Inverse_Jaco_new(x,y,z,pitch, oldtheta2, oldtheta3)
    
    oldtheta2 = oldtheta2*pi/180;
    oldtheta3 = oldtheta3*pi/180;
    phi= -pitch*pi/180;
    
    theta_1 = round(atan2(y,x),4);
    
    pr = round(sqrt(x^2+y^2),4);
    r3 = pr;
    z3 = z - 77;
    a4 = 126;
    a2 = 130;
    a3 = 124;
    r2 = round(r3 - a4*cos(phi),4);
    z2 = round(z3 - a4*sin(phi),4);
%     delta_theta_1 = atan(24/128)
    delta_theta = atan(24/128);
%     (r2^2 +z2^2-(a2^2 +a3^2))/(2*a2*a3);
    
    if (round((r2^2 +z2^2-(a2^2 +a3^2))/(2*a2*a3),2) >1)
        res = 1;
        theta_inv = zeros(4,1);
        return
    else
       c_theta_3 = round(round((r2^2 +z2^2-(a2^2 +a3^2))/(2*a2*a3),2),4);
       s_theta_3 = [round(-sqrt(1-c_theta_3^2),4); round(sqrt(1-c_theta_3^2),4)];
       theta_3_cal_matrix = round(atan2(s_theta_3, c_theta_3),4);
    end
    
    theta_2_cal_matrix = zeros(2,1);
    for n = 1:2
%         ctheta_2 = ( ( a2 + a3*cos(theta_3_matrix(n,:) )*r2 + ( a3*sin(theta_3_matrix(n,:) )*z2 )))/(r2^2 +z2^2);
%         stheta_2 = ((a2 + a3*cos(theta_3_matrix(n,:))*z2 + (a3*sin(theta_3_matrix(n,:)))*r2))/(r2^2 +z2^2);
        ctheta_2 = round(((a2 + a3*cos(theta_3_cal_matrix(n,:)))*r2 + a3*sin(theta_3_cal_matrix(n,:))*z2)/(r2^2+z2^2),4);
        stheta_2 = round(((a2 + a3*cos(theta_3_cal_matrix(n,:)))*z2 - a3*sin(theta_3_cal_matrix(n,:))*r2)/(r2^2+z2^2),4);
        theta_2_cal_matrix(n,:) = round(atan2(stheta_2,ctheta_2),4);
    end
    theta_2_matrix = theta_2_cal_matrix - pi/2 + delta_theta ;
    theta_3_matrix = theta_3_cal_matrix  + pi/2  - delta_theta ;
    
%   	for n = 1:2
%         if(theta_2_matrix(n,:)<-pi/2 ||(theta_2_matrix(n,:)> pi/2)||(theta_3_matrix(n,:))<-pi/2||(theta_3_matrix(n,:))> pi/2)
%             theta_2_matrix(n,:) = 0;
%             theta_3_matrix(n,:) = 0;
%         end
%     end
    flag = zeros(2,1);
    if(theta_2_matrix(1,1) <-pi/2 || theta_2_matrix(1,1) > pi/2 || theta_3_matrix(1,1) <-pi/2 || theta_3_matrix(1,1) > pi/2)
        flag(1,1) = 1;
    end
    if(theta_2_matrix(2,1) <-pi/2 || theta_2_matrix(2,1) > pi/2 || theta_3_matrix(2,1) <-pi/2 || theta_3_matrix(2,1) > pi/2)
        flag(2,1) = 1;
    end
%     flag
    if (flag(1,1) == 1 && flag(2,1) ==1)
       res = 1;
        theta_inv = zeros(4,1);
        return
    elseif (flag(1,1) ==1 && flag(2,1) == 0)
        theta_2 = theta_2_matrix(2,1);
        theta_3 = theta_3_matrix(2,1);
        note = 0;
    elseif(flag(2,1) ==1 && flag(1,1) == 0)
        theta_2 = theta_2_matrix(1,1);
        theta_3 = theta_3_matrix(1,1);
        note = 0;
    else
        note = 1;
    end
%     note
    if(note)
        delta1 =  abs(oldtheta2 - theta_2_matrix(1,1))+ abs(oldtheta3 - theta_3_matrix(1,1));
        delta2 =  abs(oldtheta2 - theta_2_matrix(2,1))+ abs(oldtheta3 - theta_3_matrix(2,1));
        if(delta1 < delta2)
            theta_2 = theta_2_matrix(1,1);
            theta_3 = theta_3_matrix(1,1);
        else
            theta_2 = theta_2_matrix(2,1);
            theta_3 = theta_3_matrix(2,1);
        end
    end
    theta_4 = phi - theta_2 - theta_3;
    

    if (round(theta_1,4) < round(-pi,4) || round(theta_1,4) > round(pi,4))
       res = 1;
        theta_inv = zeros(4,1);
        return
    end

    if (theta_4 < -pi/2 || theta_4 > pi/2)
       res = 1;
        theta_inv = zeros(4,1);
        return
    end
    res= 0;

    theta_inv = [theta_1; theta_2; theta_3; theta_4];
end