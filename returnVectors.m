function [xVector, yVector, zVector] = returnVectors(xCoor, yCoor, zCoor, chargeXCoor, chargeYCoor, chargeZCoor, chargeMag)
%Calculate components of electric field at given points
%Does it for x, y, and z
%k is omitted because magnitude is relative only to other points
tempXDist = (chargeXCoor - xCoor) .^ 2;
tempYDist = (chargeYCoor - yCoor) .^ 2;
tempZDist = (chargeZCoor - zCoor) .^ 2;
totalDistance = sqrt(tempXDist + tempYDist + tempZDist);
totalMagnitude = chargeMag / totalDistance;

%Set a ratio of x,y,z distances to total. Use that same ratio for 
%x,y,z magnitudes to total
xRatio = totalDistance ./ (xCoor - chargeXCoor);
xVector = totalMagnitude ./ xRatio;

yRatio = totalDistance ./ (yCoor - chargeYCoor);
yVector = totalMagnitude ./ yRatio;

zRatio = totalDistance ./ (zCoor - chargeZCoor);
zVector = totalMagnitude ./ zRatio;
%Totally lucked out on the signage of the vectors, etc

end