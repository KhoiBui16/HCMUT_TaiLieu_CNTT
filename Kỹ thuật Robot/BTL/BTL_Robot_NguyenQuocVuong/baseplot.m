function baseplot(x,y,z,color)
plot3(0,0,0);
surf(x,y,z,'FaceColor',color);
patch(x(1,:),y(1,:),z(1,:),color );
patch(x(2,:),y(2,:),z(2,:),color);
end