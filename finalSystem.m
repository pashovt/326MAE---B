% Hand calculations to estimate the first few modes
% Reference calculations

% Characteristic of Models:
    % Natural Frequency
    % Modal Damping - no damping present in the current model
    % Mode Shape

% Geometry
% Geo = imread("Geometry.png");
% imshow(Geo)
% 6 nodes 
% 5 elements

% Reduced Mass Matrix (values for translational vertical mass) - size 6x6
output = FindingArea;
MassMatrix = output.massMatrix;

% Local Stiffness Matrix - 6x6 size of every local matrix
LocalStiffnessMatrix = StiffnessMatrix(output);

% Global Stiffness Matrix
GlobalStiffnessMatrix = zeros(18,18);
GlobalStiffnessMatrix(1:6, 1:6) = LocalStiffnessMatrix.beamMatrix_1;
GlobalStiffnessMatrix(4:9, 4:9) = LocalStiffnessMatrix.beamMatrix_2;
GlobalStiffnessMatrix(7:12, 7:12) = LocalStiffnessMatrix.beamMatrix_3;
GlobalStiffnessMatrix(10:15, 10:15) = LocalStiffnessMatrix.beamMatrix_4;
GlobalStiffnessMatrix(13:18, 13:18) = LocalStiffnessMatrix.beamMatrix_5;

n = [1,2,3;4,5,6];

% Y values 
YValues(:, 1:2) = LocalStiffnessMatrix.beamMatrix_1(:, n(:,2));
YValues(:, 3:4) = LocalStiffnessMatrix.beamMatrix_2(:, n(:,2));
YValues(:, 5:6) = LocalStiffnessMatrix.beamMatrix_3(:, n(:,2));
YValues(:, 7:8) = LocalStiffnessMatrix.beamMatrix_4(:, n(:,2));
YValues(:, 9:10) = LocalStiffnessMatrix.beamMatrix_5(:, n(:,2));

Node1 = LocalStiffnessMatrix.beamMatrix_1(3:3, 3:3);

% X values
LocalStiffnessMatrix.beamMatrix_1(:, n(:,1))
LocalStiffnessMatrix.beamMatrix_2(:, n(:,1))
LocalStiffnessMatrix.beamMatrix_3(:, n(:,1))
LocalStiffnessMatrix.beamMatrix_4(:, n(:,1))
LocalStiffnessMatrix.beamMatrix_5(:, n(:,1))

% Theta values
LocalStiffnessMatrix.beamMatrix_1(:, n(:,3))
LocalStiffnessMatrix.beamMatrix_2(:, n(:,3))
LocalStiffnessMatrix.beamMatrix_3(:, n(:,3))
LocalStiffnessMatrix.beamMatrix_4(:, n(:,3))
LocalStiffnessMatrix.beamMatrix_5(:, n(:,3))


% Rearrange stiffness matrix (y, x, theta)
NewGlobalStiffnessMatrix = [];


% ModalStiffnessMatrix
% Reduction of stiffness matrix to 6x6
D = NewGlobalStiffnessMatrix(1:6, 1:6);
E = NewGlobalStiffnessMatrix(7:18, 7:18);
F = NewGlobalStiffnessMatrix(1:6, 7:18);
F2 = NewGlobalStiffnessMatrix(7:18,1:6);

% check
if F ~= transpose(F2)
    error('This is not suppose to happen')
end
ReducedStiffnessMatrix = (D-F*(E.^1)*F2);

[eigVector, DiageigValue] = eig((MassMatrix.^-1)*K);
plot(eigVector)

% Frequency matrix
eigValue = diag(DiageigValue);
% Natural Frequencies
NaturalFrequencies = sqrt(eigValue);

