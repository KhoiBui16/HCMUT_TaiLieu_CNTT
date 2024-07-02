function Draw_coordinate(UnitVec, HomoMat)
    HomoMat = HomoMat(:,4);
    HomoMat(4) = [];
    HomoMat = HomoMat';
    
    drawArrow = @(x,y,z, color) quiver3(x(1), y(1), z(1), ...
                            x(2)-x(1),y(2)-y(1),z(2)-z(1), 1, ...
                            'Color', color, 'MaxHeadSize', 2,'LineWidth', 3);
                        
   for i = 1:3
       pts = [HomoMat; UnitVec(:,i)'];
       x = pts(:,1);
       y = pts(:,2);
       z = pts(:,3);
       switch i
           case 1
               drawArrow(x, y, z, 'red');
           case 2
               drawArrow(x, y, z, 'green');
           case 3
               drawArrow(x, y, z, 'yellow');
       end
   end
    
end