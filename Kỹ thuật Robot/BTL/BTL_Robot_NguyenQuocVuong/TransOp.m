function changeCoordinates = TransOp(Coordinate, HomoMat)
    Coordinate = [Coordinate; 1 1 1];
    changeCoordinates = HomoMat*Coordinate;
    changeCoordinates = changeCoordinates(1:3, 1:3);
end