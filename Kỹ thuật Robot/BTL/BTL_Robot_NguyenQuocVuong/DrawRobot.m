function DrawRobot (theta_1, theta_2, theta_3, theta_4, handles)
%% DH table
% Link | d   | theta        |   a   | alpha
% 1      77    theta_1         0       90
% 2      0     theta_2+ 90     128      0
% S      0     -90              24      0
% 3      0     theta_3          124     0
% 4      0     theta_4          126     0
    axes(handles.RobotView);
    cla(handles.RobotView);
    opacity = round(get(handles.opacity,'value'),2);
    set(handles.edit_opacity,'string',num2str(opacity));
    theta_1 = theta_1*pi/180;
    theta_2 = theta_2*pi/180;
    theta_3 = theta_3*pi/180;
    theta_4 = theta_4*pi/180;
    ax = handles.RobotView;
    T1 = DH_Matrix(77, theta_1, 0, pi/2);
    T2 = DH_Matrix(0, theta_2 + pi/2, 128, 0);
    T3 = DH_Matrix(0, -pi/2, 24,0);
    T4 = DH_Matrix(0, theta_3, 124, 0);
    T5 = DH_Matrix(0, theta_4, 126, 0);
    A0_0 =DH_Matrix(0,0,0,0);
    A01=T1;
    A02 = T1*T2;
    A03 = T1*T2*T3;
    A04 = T1*T2*T3*T4;
    A05 = T1*T2*T3*T4*T5;

    %% Check workspace
    if handles.check_workspace.Value
        hold off
        Draw_Workspace();
        view(ax,[-180 75])
        
    else
       
        view(ax,[20 20])
    end
 %% Draw Robot
 
    %Toa do tam 0xyz5
    Ox5 = A05(1,4); Oy5 = A05(2,4);Oz5 = A05(3,4);
    tmp = A05(1:3,1:3);
    calR_P_Y = CaculateR_P_Y(tmp);
    set(handles.edit_x,'String', num2str(round(Ox5,2)));
    set(handles.edit_y,'String', num2str(round(Oy5,2)));
    set(handles.edit_z,'String', num2str(round(Oz5,2)));
    set(handles.edit_roll,'String', num2str(round(calR_P_Y(1),2)));
    set(handles.edit_pitch,'String', num2str(round(calR_P_Y(2),2)));
    set(handles.edit_yaw,'String', num2str(round(calR_P_Y(3),2)));
    % line 1
%     line1= [0 0;0 0;0 Oz1];
%     plot3(ax, line1(1,:),line1(2,:),line1(3,:),'LineWidth',5,'Color','k');
   
    %ve de
    [xbase,ybase,zbase] = cylinder([150 150],99);
%     xbase = xbase + zeros(2,100);
%     zbase = zbase + zeros(2,100);
%     ybase = ybase + zeros(2,100);
    color = [0.6, 0.2, 0.3];
    baseplot(xbase,ybase,zbase,color);
    hold on
    grid on
    col = 'b';
    % Tien hanh khoi tao cac diem ban dau va ma tran
    r = 20;
[X,Y,Z] = cylinder(r);
h = 35;
Z = Z*h;
surf(X,Y,Z)
%     x0 = [23 -46 -46 23 23 -46 -46 23];
%     y0 = [23 23 -23 -23 23 23 -23 -23];
% %     x0 = [23 0 -10 -46 -46 -10 0 23 23 0 -10 -46 -46 -10 0 23];
% %     y0 = [23 23 23 23 -23 -23 -23 -23 23 23 23 23 -23 -23 -23 -23];
%     z0 = [0 0 0 0 40 40 40 40 ];
%     boxplot(x0,y0,z0,col, opacity); 
 %link 1
x_link1=[0 A01(1,4)];
y_link1=[0 A01(2,4)];
z_link1=[0 A01(3,4)];
plot3(x_link1,y_link1,z_link1,'Linewidth',5,'color',[0.8 0.8 1 opacity ]);hold on;grid on;
scatter3( A01(1,4),A01(2,4),A01(3,4), 'SizeData',80, 'MarkerFaceColor','m','MarkerEdgeColor','m','MarkerFaceAlpha',opacity,'MarkerEdgeAlpha',opacity);

%link 2
x_link2=[A01(1,4) A02(1,4)];
y_link2=[A01(2,4) A02(2,4)];
z_link2=[A01(3,4) A02(3,4)];
scatter3( A02(1,4),A02(2,4),A02(3,4), 'SizeData',80, 'MarkerFaceColor','m','MarkerEdgeColor','m','MarkerFaceAlpha',opacity,'MarkerEdgeAlpha',opacity);
plot3(x_link2,y_link2,z_link2,'Linewidth',5,'color',[0.8 0.8 1 opacity ]);hold on;grid on;

%link 2p
x_link2p=[A02(1,4) A03(1,4)];
y_link2p=[A02(2,4) A03(2,4)];
z_link2p=[A02(3,4) A03(3,4)];
scatter3( A03(1,4),A03(2,4),A03(3,4), 'SizeData',80, 'MarkerFaceColor','m','MarkerEdgeColor','m','MarkerFaceAlpha',opacity,'MarkerEdgeAlpha',opacity);
plot3(x_link2p,y_link2p,z_link2p,'Linewidth',5,'color',[0.8 0.8 1 opacity ]);hold on;grid on;

%link 3
x_link3=[A03(1,4) A04(1,4)];
y_link3=[A03(2,4) A04(2,4)];
z_link3=[A03(3,4) A04(3,4)];
scatter3( A04(1,4),A04(2,4),A04(3,4), 'SizeData',80, 'MarkerFaceColor','m','MarkerEdgeColor','m','MarkerFaceAlpha',opacity,'MarkerEdgeAlpha',opacity);
plot3(x_link3,y_link3,z_link3,'Linewidth',5,'color',[0.8 0.8 1 opacity ]);hold on;grid on;

%link 4
x_link4=[A04(1,4) A05(1,4)];
y_link4=[A04(2,4) A05(2,4)];
z_link4=[A04(3,4) A05(3,4)];
scatter3( A05(1,4),A05(2,4),A05(3,4), 'SizeData',80, 'MarkerFaceColor','m','MarkerEdgeColor','m','MarkerFaceAlpha',opacity,'MarkerEdgeAlpha',opacity);
plot3(x_link4,y_link4,z_link4,'Linewidth',5,'color',[0.8 0.8 1 opacity ]);hold on;grid on;
    
%     %Toa do tam 0xyz1
%     Ox1 = T1(1,4); Oy1 = T1(2,4);Oz1 = T1(3,4);
%     %Toa do tam 0xyz2
%     
%     Ox2 = A02(1,4); Oy2 = A02(2,4);Oz2 = A02(3,4);
%     %Toa do tam 0xyz3
%     
%     Ox3 = A03(1,4); Oy3 = A03(2,4);Oz3 = A03(3,4);
%     %Toa do tam 0xyz4
%     
%     Ox4 = A04(1,4); Oy4 = A04(2,4);Oz4 = A04(3,4);
    %Toa do tam 0xyz5
    Ox5 = A05(1,4); Oy5 = A05(2,4);Oz5 = A05(3,4);
    tmp = A05(1:3,1:3);
    calR_P_Y = CaculateR_P_Y(tmp);
    set(handles.edit_x,'String', num2str(round(Ox5,2)));
    set(handles.edit_y,'String', num2str(round(Oy5,2)));
    set(handles.edit_z,'String', num2str(round(Oz5,2)));
    set(handles.edit_roll,'String', num2str(round(calR_P_Y(1),2)));
    set(handles.edit_pitch,'String', num2str(round(calR_P_Y(2),2)));
    set(handles.edit_yaw,'String', num2str(round(calR_P_Y(3),2)));
    %current
    set(handles.edit_x_cur,'String', num2str(round(Ox5,2)));
    set(handles.edit_y_cur,'String', num2str(round(Oy5,2)));
    set(handles.edit_z_cur,'String', num2str(round(Oz5,2)));
   
    set(handles.edit_pitch_cur,'String', num2str(round(calR_P_Y(2),2)));
   
    % line 1
%     line1= [0 0;0 0;0 Oz1];
%     plot3(ax, line1(1,:),line1(2,:),line1(3,:),'LineWidth',5,'Color','k');
   
    %ve de
%     [xbase,ybase,zbase] = cylinder([150 150],99);
% %     xbase = xbase + zeros(2,100);
% %     zbase = zbase + zeros(2,100);
% %     ybase = ybase + zeros(2,100);
%     color = [0.6, 0.2, 0.3];
%     baseplot(xbase,ybase,zbase,color);
%     hold on
%     grid on
%     col = 'b';
%     % Tien hanh khoi tao cac diem ban dau va ma tran
%     x0 = [23 -46 -46 23 23 -46 -46 23];
%     y0 = [23 23 -23 -23 23 23 -23 -23];
% %     x0 = [23 0 -10 -46 -46 -10 0 23 23 0 -10 -46 -46 -10 0 23];
% %     y0 = [23 23 23 23 -23 -23 -23 -23 23 23 23 23 -23 -23 -23 -23];
%     z0 = [0 0 0 0 40 40 40 40 ];
%     boxplot(x0,y0,z0,col, opacity); 
%     
%     x1=[23 -23 -23 23 23 -23 -23 23];
%     y1=[23 23 -23 -23 23 23 -23 -23];
%     z1=[40 40  40  40 70 70 70 70];

%     x2=[15 -15 -15 15 15 -15 -15 15];
%     y2=[15 15 -15 -15 15 15 -15 -15];
%     z2=[70 70 70 70 215 215 215 215];
%     x2=[15 -15 -15 15 15 -15 -15 15];
%     y2=[15 15 -15 -15 15 15 -15 -15];
%     z2=[70 70 70 70 195 195 195 195];

%     x3=[24 -10 -10 24 24 -10 -10 24];
%     y3=[15 15 -15 -15 15 15 -15 -15];
%     z3=[195 195 195 195 215 215 215 215];
%     x3=[24 -15 -15 24 24 -15 -15 24];
%     y3=[15 15 -15 -15 15 15 -15 -15];
%     z3=[195 195 195 195 215 215 215 215];
% 
%     x4=[148 24 24 148 148 24 24 148];
%     y4=[15 15 -15 -15 15 15 -15 -15];
%     z4=[195 195 195 195 215 215 215 215];
% 
%     x5=[201 148 148 201 201 148 148 201];
%     y5=[10 10 -10 -10 10 10 -10 -10];
%     z5=[195 195 195 195 215 215 215 215];
% 
%     x9=[220 200 200 220 220 200 200 220];
%     y9=[33 33 -33 -33 33 33 -33 -33];
%     z9=[195 195 195 195 215 215 215 215];
% 
%     x10=[274 220 220 274 274 220 220 274];
%     y10=[30 30 15 15 30 30 15 15];
%     z10=[195 195 195 195 215 215 215 215];
% 
%     x11=[274 220 220 274 274 220 220 274];
%     y11=[-15 -15 -30 -30 -15 -15 -30 -30];
%     z11=[195 195 195 195 215 215 215 215];
%     
%     [x0,z0,y0]=cylinder([22 22],99);
%     x6=x0+ones(2,100)*0;
%     z6=z0+ones(2,100)*77;
%     y6=y0*40-ones(2,100)*20;
%     [x0,z0,y0]=cylinder([17 17],99);
%     x7=x0+ones(2,100)*24;
%     z7=z0+ones(2,100)*205;
%     y7=y0*40-ones(2,100)*20;
%     [x0,z0,y0]=cylinder([15 15],99);
%     x8=x0+ones(2,100)*148;
%     z8=z0+ones(2,100)*205;
%     y8=y0*40-ones(2,100)*20;
    
%     %Tinh toan ma tran xoay
%     R1 = Rotate(theta_1);
%     R2 = Rotate(theta_2);
%     R3 = Rotate(theta_3);
%     R4 = Rotate(theta_4);
    
    % Cap nhat cua diem cua cac hinh hop (link) theo theta_1, theta_2,
    % theta_3, theta_4
%     for i = 1:8
%         tmp=R1*[x1(i);y1(i);z1(i);1];
%         x1(i)=tmp(1);
%         y1(i)=tmp(2);
%         z1(i)=tmp(3);
%         tmp=T1*R2*inv(T1)*R1*[x2(i);y2(i);z2(i);1];
%         x2(i)=tmp(1);
%         y2(i)=tmp(2);
%         z2(i)=tmp(3);
%         tmp=T1*R2*inv(T1)*R1*[x3(i);y3(i);z3(i);1];
%         x3(i)=tmp(1);
%         y3(i)=tmp(2);
%         z3(i)=tmp(3);    
%         tmp=T1*T2*T3*R3*inv(T2*T3)*R2*inv(T1)*R1*[x4(i);y4(i);z4(i);1];
%         x4(i)=tmp(1);
%         y4(i)=tmp(2);
%         z4(i)=tmp(3);
%         tmp=T1*T2*T3*T4*R4*inv(T4)*R3*inv(T2*T3)*R2*inv(T1)*R1*[x5(i);y5(i);z5(i);1];
%         x5(i)=tmp(1);
%         y5(i)=tmp(2);
%         z5(i)=tmp(3);  
%         tmp=T1*T2*T3*T4*R4*inv(T4)*R3*inv(T2*T3)*R2*inv(T1)*R1*[x9(i);y9(i);z9(i);1];
%         x9(i)=tmp(1);
%         y9(i)=tmp(2);
%         z9(i)=tmp(3);  
%         tmp=T1*T2*T3*T4*R4*inv(T4)*R3*inv(T2*T3)*R2*inv(T1)*R1*[x10(i);y10(i);z10(i);1];
%         x10(i)=tmp(1);
%         y10(i)=tmp(2);
%         z10(i)=tmp(3);
%         tmp=T1*T2*T3*T4*R4*inv(T4)*R3*inv(T2*T3)*R2*inv(T1)*R1*[x11(i);y11(i);z11(i);1];
%         x11(i)=tmp(1);
%         y11(i)=tmp(2);
%         z11(i)=tmp(3);
%     end
%     for i=1:2
%       for j=1:100
%         tmp = R1*[x6(i,j);y6(i,j);z6(i,j);1];
%         x6(i,j)=tmp(1);
%         y6(i,j)=tmp(2);
%         z6(i,j)=tmp(3);
%         tmp = T1*R2*inv(T1)*R1*[x7(i,j);y7(i,j);z7(i,j);1];
%         x7(i,j)=tmp(1);
%         y7(i,j)=tmp(2);
%         z7(i,j)=tmp(3);
%         tmp = T1*T2*T3*R3*inv(T2*T3)*R2*inv(T1)*R1*[x8(i,j);y8(i,j);z8(i,j);1];
%         x8(i,j)=tmp(1);
%         y8(i,j)=tmp(2);
%         z8(i,j)=tmp(3);
%       end
%     end 
    %Ve link
%     boxplot(x1,y1,z1,col,opacity);
%     boxplot(x2,y2,z2,col,opacity);
%     boxplot(x3,y3,z3,col,opacity);
%     boxplot(x4,y4,z4,col,opacity);
%     boxplot(x5,y5,z5,col,opacity);
%     boxplot(x9,y9,z9,col,opacity);
%     boxplot(x10,y10,z10,col,opacity);
%     boxplot(x11,y11,z11,col,opacity);
%     cylinderplot(x6,y6,z6,col,opacity);
%     cylinderplot(x7,y7,z7,col,opacity);
%     cylinderplot(x8,y8,z8,col,opacity);
    % ve joint
%     scatter3(ax, 0, 0, 0, 'SizeData', 200, 'MarkerFaceColor', 'b');
%     scatter3(ax, Ox1,Oy1,Oz1, 'SizeData',20, 'MarkerFaceColor','k','MarkerEdgeColor','b');
    %uistack(point_1,'top');


%     % line 2
%     line2=([Ox1 Ox2;Oy1 Oy2; Oz1 Oz2]);
%     plot3(ax, line2(1,:),line2(2,:),line2(3,:),'LineWidth',5,'Color','k');
%     scatter3(ax, 0, 0, Oz1, 'SizeData', 200, 'MarkerFaceColor', 'b');
%     scatter3(ax, Ox2,Oy2,Oz2, 'SizeData',20, 'MarkerFaceColor','k','MarkerEdgeColor','k');
% 
% 
%     line3=([Ox2 Ox3;Oy2 Oy3;Oz2 Oz3]);
%     plot3(ax, line3(1,:),line3(2,:),line3(3,:),'LineWidth',5,'Color','k');
%     scatter3(ax, Ox3, Oy3, Oz3, 'SizeData', 200, 'MarkerFaceColor', 'b');
%     scatter3(ax, Ox3,Oy3,Oz3, 'SizeData',20, 'MarkerFaceColor','k','MarkerEdgeColor','b');
% 
% 
%     line4=([Ox3 Ox4;Oy3 Oy4;Oz3 Oz4]);
%     plot3(ax, line4(1,:),line4(2,:),line4(3,:),'LineWidth',5,'Color','k');
%     scatter3(ax, Ox4, Oy4, Oz4, 'SizeData', 200, 'MarkerFaceColor', 'b');
%     scatter3(ax, Ox4,Oy4,Oz4, 'SizeData',20, 'MarkerFaceColor','k','MarkerEdgeColor','b');
% 
%     line5=([Ox4 Ox5;Oy4 Oy5;Oz4 Oz5]);
%     plot3(ax, line5(1,:),line5(2,:),line5(3,:),'LineWidth',5,'Color','k');
%     scatter3(ax, Ox5, Oy5, Oz5, 'SizeData', 200, 'MarkerFaceColor', 'r');
%     scatter3(ax, Ox5,Oy5,Oz5, 'SizeData',20, 'MarkerFaceColor','r','MarkerEdgeColor','r');
    %% Draw Coordinates
    A00 = [1 0 0 0; 0 1 0 0; 0 1 0 0; 0 0 0 1]';
    base = [50 0 0; 0 50 0; 0 0 50]';
%     if handles.check_c1.Value
%         Draw_coordinate(base, A00);
%     end
%     if handles.check_c2.Value
%         TCoordi01 = TransOp(base, T1);
%         Draw_coordinate(TCoordi01, T1);
%     end
%     if handles.check_c3.Value
%         TCoordi03 = TransOp(base,A03);
%         Draw_coordinate(TCoordi03, A03);
%     end
%     if handles.check_c4.Value
%         TCoordi04 = TransOp(base,A04);
%         Draw_coordinate(TCoordi04, A04);
%     end
%     if handles.check_end_effector.Value
%         TCoordi05 = TransOp(base,A05);
%         Draw_coordinate(TCoordi05, A05);
%     end
    if handles.check_all.Value
        Draw_coordinate(base, A00);
        TCoordi01 = TransOp(base, T1);
        Draw_coordinate(TCoordi01, T1);
        TCoordi03 = TransOp(base,A03);
        Draw_coordinate(TCoordi03, A03);
        TCoordi04 = TransOp(base,A04);
        Draw_coordinate(TCoordi04, A04);
        TCoordi05 = TransOp(base,A05);
        Draw_coordinate(TCoordi05, A05);
    end
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
%     xlim([-500,500])
%     ylim([-500,500])
%     zlim([0,500])
%     % view([135 20])
%     % view([230 20])
%     hold on;

xlabel('Truc x');
ylabel('Truc y');
zlabel('Truc z');   
axis([-500, 500,-500 , 500, -200, 550]);
h = rotate3d;   
h.Enable = 'on';
    
    
    title(ax,'OPEN MANIPULATOR X');
 %   hold off
%     pause(0.000001);

end