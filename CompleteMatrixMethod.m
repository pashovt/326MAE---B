close all
clear
clc

% Hand calculations using Matrix Method to estimate the first few modes of
% the Geometrical System
% Calculations are to be referenced/explained

% Geometry/System
% Geo = imread("Geometry.png");
% imshow(Geo)

% Characteristic of Modes:
    % Natural Frequency
    % Modal Damping - no damping present in the current model
    % Mode Shape

% Reduced Mass Matrix (values for translational vertical mass) - size 6x6
    % The values for "translational vertical mass" are the same for x
    % (horizontal) and y (vertical) components, and the i (rotational) is
    % equal to zero - no rotation present in the current study case.
    % X and Y values are identical so the originally calculated values 
    % for the mass were used.
ToMeter = 1000;
output = FindingMassMatrix(ToMeter);
MassMatrix = output.massMatrix;

% Local Stiffness Matrix - 6x6 size of every local matrix
LocalStiffnessMatrix = StiffnessMatrix(ToMeter);

LargeLocalMatrix1 = zeros(18,18);
LargeLocalMatrix2 = zeros(18,18);
LargeLocalMatrix3 = zeros(18,18);
LargeLocalMatrix4 = zeros(18,18);
LargeLocalMatrix5 = zeros(18,18);

LargeLocalMatrix1(1:6, 1:6) = LocalStiffnessMatrix.beamMatrix_1;
LargeLocalMatrix2(4:9, 4:9) = LocalStiffnessMatrix.beamMatrix_2;
LargeLocalMatrix3(7:12, 7:12) = LocalStiffnessMatrix.beamMatrix_3;
LargeLocalMatrix4(10:15, 10:15) = LocalStiffnessMatrix.beamMatrix_4;
LargeLocalMatrix5(13:18, 13:18) = LocalStiffnessMatrix.beamMatrix_5;

% Global Stiffness Matrix
GlobalStiffnessMatrix = LargeLocalMatrix1 + LargeLocalMatrix2 + ...
    LargeLocalMatrix3 + LargeLocalMatrix4 + LargeLocalMatrix5;

% Added value - for better computation
GlobalStiffnessMatrix(2,2) = GlobalStiffnessMatrix(2,2)+100;
GlobalStiffnessMatrix(17,17) = GlobalStiffnessMatrix(17,17)+100;

% New rearranged Global stiffness matrix
Nodes = 6;
DoF = 3;
nn = zeros(Nodes, DoF);
nn(1, :) = [1,2,3];
for jj = 1:Nodes-1
    nn(jj+1, :) = nn(jj,:)+3;
end
ColumnOrder = [nn(:,2)', nn(:,1)', nn(:,3)'];


K1 = GlobalStiffnessMatrix(ColumnOrder, :);
% Rearrange stiffness matrix (y, x, theta)
NewGlobalStiffnessMatrix = K1(:, ColumnOrder);
% Make changes to matrix - zero values are replaced with a number that is
% closed to zero so that the Global Stiffness Matrix is not singular or 
% badly scaled
NewGlobalStiffnessMatrix(NewGlobalStiffnessMatrix<5e-7 & NewGlobalStiffnessMatrix>-5e-7)=1e-7;

% Reduction of stiffness matrix to 6x6
D = NewGlobalStiffnessMatrix(1:6, 1:6);
E = NewGlobalStiffnessMatrix(7:18, 7:18);
F = NewGlobalStiffnessMatrix(1:6, 7:18);
F2 = NewGlobalStiffnessMatrix(7:18,1:6);
% check
if F ~= transpose(F2)
    error('This is not suppose to happen')
end
ReducedStiffnessMatrix = (D-F*inv(E)*F2);

% EigenValues and EigenVectors for the system (M.^-1*K)
[eigVector, DiageigValue] = eig(inv(MassMatrix)*ReducedStiffnessMatrix);
% Frequency matrix - DiageigValue
eigValue = diag(DiageigValue);
% Natural Frequencies
% In Hz
NaturalFrequencies = real(sqrt(eigValue)/(2*pi));
% ceil(NaturalFrequencies)

% Plotting the eigVector to see if they are simular to the ANSYS Modal
% Analysis results
% The last 2 value are ignored because they are to small and it is not
% expected to see a mode shape at such low frequency
for ii = 1:length(eigVector)-2
    figure('Name', string(strcat('Mode ', {' '}, num2str(ii)))); 
    plot(eigVector(:, ii))
end