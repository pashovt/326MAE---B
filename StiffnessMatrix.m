function LocalStiffnessMatrix = StiffnessMatrix(output)
% Generates the stiffness matrixes for the whole system
% Expected input
    % output - generated output from the FindingMassMatrix function.
    % It is an struct variable and contains the areas for each individual 
    % section of the beam.
%
%  Returns a struct variable that contains the local stiffness matrixes of 
% the system.

% ZY view
thickness = 4.8;
height = 25.4;
topLength = 50.8;

% XY view
L_1 = 139;
L_2 = 88.41;
L_3 = 133;
L_4 = 88.41;
L_5 = 203;

% Areas of sections
Side1 = thickness*height;
Side2 = thickness*height;
Top = (topLength-2*thickness)*thickness;

% Distance to centroid of segment
ToCentroidSide1 = height/2;
ToCentroidSide2 = height/2;
ToCentroidTop = height - thickness + thickness/2;

% Distance to centroid of shape
TotalArea = Side1 + Side2 + Top;
% Centroid location
YA = (Side1*ToCentroidSide1) + (Side2*ToCentroidSide2) + (Top*ToCentroidTop);

Centroid = YA/TotalArea;

Ix = ((1/12)*thickness*height.^3) + Side1*abs(ToCentroidSide1-Centroid).^2 + ...
    ((1/12)*(topLength-2*thickness)*thickness.^3) + Top*abs(ToCentroidTop-Centroid).^2 + ...
    ((1/12)*thickness*height.^3) + Side2*abs(ToCentroidSide2-Centroid).^2;


beamMatrix_1 = LocalBeamStiffnessMatrix(output.Trapezium_area_1Side, L_1, Ix, 0);
beamMatrix_2 = LocalBeamStiffnessMatrix(output.Area_2Side, L_2, Ix, -111.81);
beamMatrix_3 = LocalBeamStiffnessMatrix(output.Trapezium_area_3Side, L_3, Ix, 0);
beamMatrix_4 = LocalBeamStiffnessMatrix(output.Area_4Side, L_4, Ix, 111.81);
beamMatrix_5 = LocalBeamStiffnessMatrix(output.Trapezium_area_5Side, L_5, Ix, 0);

LocalStiffnessMatrix.beamMatrix_1 = beamMatrix_1;
LocalStiffnessMatrix.beamMatrix_2 = beamMatrix_2;
LocalStiffnessMatrix.beamMatrix_3 = beamMatrix_3;
LocalStiffnessMatrix.beamMatrix_4 = beamMatrix_4;
LocalStiffnessMatrix.beamMatrix_5 = beamMatrix_5;

end