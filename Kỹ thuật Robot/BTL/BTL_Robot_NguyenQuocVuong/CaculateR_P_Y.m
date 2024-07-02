function [res] = CaculateR_P_Y(T)
    cal = sqrt(T(3,2)^2 + T(3,3)^2);
    pitch = atan2(-T(3,1),cal);
    if pitch == pi/2
        yaw = 0;
        roll = atan2(T(1,2),T(2,2));
    elseif pitch == -pi/2
        yaw = 0;
        roll = -atan2(T(1,2),T(2,2));
    else
        yaw = atan2(T(2,1)/cos(pitch), T(1,1)/cos(pitch));
        roll = atan2(T(3,2)/cos(pitch), T(3,3)/cos(pitch));
    end
    res = [roll pitch yaw]*(180/pi);
end