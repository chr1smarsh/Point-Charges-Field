%Takes in locations and charge sign/magnitudes, makes 3d vector field
%Maybe do a 3D line that follows a field line path?
%plot3(x's, y's, z's)


%Input units for the session
format compact;
disp('Welcome!');
numCharges = input('How many charges do you have to input? ');
squareDimensions = input('How many points do you want? ');

%Input charge locations, [mag, x, y, z]
chargeMatrix = zeros(numCharges, 4);
for i = 1:numCharges
    chargeMatrix(i, 1) = input('Magnitude? ');
    chargeMatrix(i, 2) = input('X coor? ');
    chargeMatrix(i, 3) = input('Y coor? ');
    chargeMatrix(i, 4) = input('Z coor? ');
end

%Determine bounds for vector field to encompass  [maxX, maxY, maxZ
%Lower and uppermost coordinate                   minX, minY, minZ]
bounds = zeros(2, 3);
for i = 1:3
    bounds(1, i) = max(chargeMatrix(:, i + 1));
    bounds(2, i) = min(chargeMatrix(:, i + 1));
    
end
%Create vectors with coordinates
xRange = bounds(1,1) - bounds(2,1); xRange = xRange + 2 .* (xRange == 0);
yRange = bounds(1,2) - bounds(2,2); yRange = yRange + 2 .* (yRange == 0);%Artificially make range 2
zRange = bounds(1,3) - bounds(2,3); zRange = zRange + 2 .* (zRange == 0);%If its equal to zero
xCoors = bounds(2,1) - .5 .* xRange:xRange ./ ((squareDimensions - 1) ./ 2):bounds(1,1) + .5 .* xRange;
yCoors = bounds(2,2) - .5 .* yRange:yRange ./ ((squareDimensions - 1) ./ 2):bounds(1,2) + .5 .* yRange;
zCoors = bounds(2,3) - .5 .* zRange:zRange ./ ((squareDimensions - 1) ./ 2):bounds(1,3) + .5 .* zRange;

%Create 4D array. Each point in 3D array contains its own 3D coordinates,
%as well as the 3 components of the vector at that point
vectorArray = zeros(squareDimensions,squareDimensions,squareDimensions,6);

%Load coordinates in them
%Calculate vector components
for x = 1:squareDimensions
    for y = 1:squareDimensions
        for z = 1:squareDimensions
            vectorArray(x,y,z,1) = xCoors(x);
            vectorArray(x,y,z,2) = yCoors(y);
            vectorArray(x,y,z,3) = zCoors(z);
            for i = 1:numCharges
                xCr = xCoors(x);
                yCr = yCoors(y);
                zCr = zCoors(z);
                chgMag = chargeMatrix(i, 1);
                chgX = chargeMatrix(i, 2);
                chgY = chargeMatrix(i, 3);
                chgZ = chargeMatrix(i, 4);
                [tempXVector, tempYVector, tempZVector] = returnVectors(xCr,yCr,zCr,chgX,chgY,chgZ,chgMag);
                vectorArray(x,y,z,4) = vectorArray(x,y,z,4) + tempXVector;
                vectorArray(x,y,z,5) = vectorArray(x,y,z,5) + tempYVector;
                vectorArray(x,y,z,6) = vectorArray(x,y,z,6) + tempZVector;
            end
        end
    end
end

quiver3(vectorArray(:,:,:,1), vectorArray(:,:,:,2), vectorArray(:,:,:,3), vectorArray(:,:,:,4), vectorArray(:,:,:,5), vectorArray(:,:,:,6));

