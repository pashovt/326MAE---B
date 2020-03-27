close all
clear
clc

% Hand calculations using Matrix Method to estimate the first few modes of
% the Geometrical System
% Calculations are to be referenced/explained

% Geometry/System
% Geo = imread("../Geometry.png");
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
output = FindingMassMatrix();
MassMatrix = output.massMatrix;

% Local Stiffness Matrix - 6x6 size of every local matrix
LocalStiffnessMatrix = StiffnessMatrix(output);

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
GlobalStiffnessMatrix(2,2) = GlobalStiffnessMatrix(2,2)+50;
GlobalStiffnessMatrix(17,17) = GlobalStiffnessMatrix(17,17)+50;

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
NewGlobalStiffnessMatrix(NewGlobalStiffnessMatrix<5 & NewGlobalStiffnessMatrix>-5)=1e-7;

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
% In rad/s
NaturalFrequencies = real(sqrt(eigValue));
% In Hz
Frequencies = NaturalFrequencies./2/pi;
Frequencies
% Plotting the eigVector to see if they are simular to the ANSYS Modal
% Analysis results
figure(); plot(eigVector)
legend('Mode 1', 'Mode 2', 'Mode 3', 'Mode 4', 'Mode 5', 'Mode 6')

% 2D Orthogonality
figure
hold on
for j = 1:length(eigVector)
    for i = 1:length(eigVector)-1
        plot([0 eigVector(i, j)], [0 eigVector(i+1, j)], 'b-')
    end
end
axis equal
 
% 3D Orthogonality
tout = linspace(0,20,1000);
v1 = eigVector(:,1);
v2 = eigVector(:,2);
v3 = eigVector(:,3);
v4 = eigVector(:,4);
v5 = eigVector(:,5);
v6 = eigVector(:,6);

% v1'
% v2'
% v3'
% v4'
% v5'
% v6'

l1 = eigValue(1);
l2 = eigValue(2);
l3 = eigValue(3);
l4 = eigValue(4);
l5 = eigValue(5);
l6 = eigValue(6);
% ceil(l1)
% ceil(l2)
% ceil(l3)
% ceil(l4)
% ceil(l5)
% ceil(l6)
figure()
x1mode1 = v1(1)*exp(l1*tout);
x2mode1 = v1(2)*exp(l1*tout);
% x3mode1 = v1(3)*exp(l1*tout);
% x4mode1 = v1(4)*exp(l1*tout);
% x5mode1 = v1(5)*exp(l1*tout);
% x6mode1 = v1(6)*exp(l1*tout);
plot3(x1mode1,x2mode1,tout,'b-')
x1mode2 = v2(1)*exp(l2*tout);
x2mode2 = v2(2)*exp(l2*tout);
% x3mode2 = v2(3)*exp(l2*tout);
% x4mode2 = v2(4)*exp(l2*tout);
% x5mode2 = v2(5)*exp(l2*tout);
% x6mode2 = v2(6)*exp(l2*tout);
hold on
plot3(x1mode2,x2mode2,tout,'r-')
xlabel('x1')
ylabel('x2')
zlabel('t')