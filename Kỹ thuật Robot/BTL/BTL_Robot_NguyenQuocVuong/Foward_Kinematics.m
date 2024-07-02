function yaw = Foward_Kinematics(theta_1, theta_2, theta_3, theta_4)
    T1 = DH_Matrix(77, theta_1, 0, pi/2);
    T2 = DH_Matrix(0, theta_2 + pi/2, 128, 0);
    T3 = DH_Matrix(0, -pi/2, 24,0);
    T4 = DH_Matrix(0, theta_3, 124, 0);
    T5 = DH_Matrix(0, theta_4, 126, 0);
    A05 = T1*T2*T3*T4*T5;
    calR_P_Y = CaculateR_P_Y(A05(1:3,1:3));
    yaw = calR_P_Y(3)*pi/180;
end