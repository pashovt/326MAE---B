function LocalStiffnessMatrix = StiffnessMatrix(ToMeter)
% Generates the stiffness matrixes for the whole system
% Expected input
    % ToMeter - specific if the output is expected to be in meters or 
    % milimiters 
%
%  Returns a struct variable that contains the local stiffness matrixes of 
% the system.

% ZY view
thickness = 4.8/ToMeter;
height = 25.4/ToMeter;
topLength = 50.8/ToMeter;

% XY view
L_1 = 139/ToMeter;
L_2 = 88.41/ToMeter;
L_3 = 133/ToMeter;
L_4 = 88.41/ToMeter;
L_5 = 203/ToMeter;

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

Ix = ((1/12)*thickness*height.^3) + Side1*(ToCentroidSide1-Centroid).^2 + ...
    ((1/12)*(topLength-2*thickness)*thickness.^3) + Top*(ToCentroidTop-Centroid).^2 + ...
    ((1/12)*thickness*height.^3) + Side2*(ToCentroidSide2-Centroid).^2;

if ToMeter == 1 % in mm
    E = 68.9*10.^6; % 68.9 GPa - Youngs Modulus 
elseif ToMeter == 1000 % in m
    E = 68.9e+9; % 68.9 GPa - Youngs Modulus
end

beamMatrix_1 = LocalBeamStiffnessMatrix(TotalArea, L_1, Ix, E, 0);
beamMatrix_2 = LocalBeamStiffnessMatrix(TotalArea, L_2, Ix, E, -43.62);
beamMatrix_3 = LocalBeamStiffnessMatrix(TotalArea, L_3, Ix, E, 0);
beamMatrix_4 = LocalBeamStiffnessMatrix(TotalArea, L_4, Ix, E, 43.62);
beamMatrix_5 = LocalBeamStiffnessMatrix(TotalArea, L_5, Ix, E, 0);

LocalStiffnessMatrix.beamMatrix_1 = beamMatrix_1;
LocalStiffnessMatrix.beamMatrix_2 = beamMatrix_2;
LocalStiffnessMatrix.beamMatrix_3 = beamMatrix_3;
LocalStiffnessMatrix.beamMatrix_4 = beamMatrix_4;
LocalStiffnessMatrix.beamMatrix_5 = beamMatrix_5;

end