function [res, theta_inv] = Check_Inverse_Jaco(x, y, z, phi)
    phi = -phi*pi/180;
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
    delta_theta = atan(128/24);
%     (r2^2 +z2^2-(a2^2 +a3^2))/(2*a2*a3);

    if (round((r2^2 +z2^2-(a2^2 +a3^2))/(2*a2*a3),2) >1)
        res = 1;
        theta_inv = zeros(4,1);
        return
    else
       c_theta_3 = round((r2^2 +z2^2-(a2^2 +a3^2))/(2*a2*a3),2);
       s_theta_3 = [round(-sqrt(1-c_theta_3^2),4); round(sqrt(1-c_theta_3^2),4)];
       theta_3_matrix = round(atan2(s_theta_3, c_theta_3),4);
    end
    flag = 0;
    for n = 1:2
%         ctheta_2 = ( ( a2 + a3*cos(theta_3_matrix(n,:) )*r2 + ( a3*sin(theta_3_matrix(n,:) )*z2 )))/(r2^2 +z2^2);
%         stheta_2 = ((a2 + a3*cos(theta_3_matrix(n,:))*z2 + (a3*sin(theta_3_matrix(n,:)))*r2))/(r2^2 +z2^2);
        ctheta_2 = round(((a2 + a3*cos(theta_3_matrix(n,:)))*r2 + a3*sin(theta_3_matrix(n,:))*z2)/(r2^2+z2^2),4);
        stheta_2 = round(((a2 + a3*cos(theta_3_matrix(n,:)))*z2 - a3*sin(theta_3_matrix(n,:))*r2)/(r2^2+z2^2),4);
        theta_2_cal = round(atan2(stheta_2,ctheta_2),4);
        if(theta_2_cal >= 0 && theta_2_cal  <= pi/2 + delta_theta  && theta_3_matrix(n,:) >= -pi/2 - delta_theta && theta_3_matrix(n,:) <= 0)
            theta_3_cal = round(theta_3_matrix(n,:),4);
            break
        else
            flag = flag + 1;
            continue
        end
    end
    if (flag ==2)
        res = 1;
        theta_inv = zeros(4,1);
        return
    end
    
  	theta_2 = round(theta_2_cal - delta_theta,4);
    theta_3 = round(theta_3_cal + delta_theta,4);
    theta_4 = round(phi - theta_2 - theta_3,4);
    
    
    
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