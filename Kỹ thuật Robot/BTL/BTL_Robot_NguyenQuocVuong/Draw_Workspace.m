function Draw_Workspace()
hold on
r = sqrt(378^2+24^2);
[u,v] = meshgrid(linspace(0,2*pi,30),linspace(0,pi,30));
x = r.*cos(u).*sin(v);
y = r.*sin(u).*sin(v);
z = r.*cos(v)+77;
color = [0.5 0.5 0.5];
surf(x,y,z,'EdgeColor','none','Facecolor',color,'Facealpha',0.15);

end