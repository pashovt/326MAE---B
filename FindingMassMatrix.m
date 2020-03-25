function output = FindingMassMatrix()
% Finds the area for each section of the '../Geometry.png' system.
% The area is found for the side and the cut top section of the ZY view -
    % specific cross section of the beam
    % output.Trapezium_area_1Side
    % output.Area_2Side
    % output.Trapezium_area_3Side
    % output.Area_4Side
    % output.Trapezium_area_5Side
    % output.Trapezium_area_1Top
    % output.Area_2Top
    % output.Trapezium_area_3Top
    % output.Area_4Top
    % output.Trapezium_area_5Top
%
% The cross section is symmetrical - 2 side and a top
% The Volume is found for each section along with the total volume of the
% beam. 
% It Volume is in m.^3
    % output.Volume_1
    % output.Volume_2
    % output.Volume_3
    % output.Volume_4
    % output.Volume_5
    % output.TotalVolume 
%
% Using the found Volume and the known density of the material that the
% beam is from the mass of each section and the total mass of system were
% found. 
% Mass is in kg
    % output.Mass_1
    % output.Mass_2
    % output.Mass_3
    % output.Mass_4
    % output.Mass_5
    % output.mass
%
% From the masses of each section the mass matrix was constructed. The
% masses are 5 and the matrix is 6x6. It was constructed based on dividing
% the mass on nodes - each node has half the mass of the element it belongs
% to. Example:
    % m1 = 5kg
    % m2 = 5kg
    % m3 = 5kg
    % m4 = 5kg
    % m5 = 5kg
    %
% Matrix = [ (m1)/2       0           0          0          0           0
%               0    (m1)/2+(m2)/2    0          0          0           0
%               0         0     (m2)/2+(m3)/2    0          0           0
%               0         0           0    (m3)/2+(m4)/2    0           0
%               0         0           0          0     (m4)/2+(m5)/2    0
%               0         0           0          0          0        (m5)/2]
%
% This is point mass allocation
    % output.massMatrix [6×6 double]

%% Sides Area
depthSide = 4.8;
Sidedegree = 21.81;
Sideheight = 25.4;

SideB_diff = tand(Sidedegree)*Sideheight;
SideHypothenuse = Sideheight/cosd(Sidedegree);

% Section 1
B1_1Side = 139;
B2_1Side = B1_1Side - SideB_diff;
output.Trapezium_area_1Side = ((B1_1Side+B2_1Side)/2)*Sideheight;
% ceil(output.Trapezium_area_1Side)

% Section 2
A_2Side = SideHypothenuse;
B_2Side = 88.41;
output.Area_2Side = A_2Side * B_2Side; 
% ceil(output.Area_2Side)

% Section 3
B2_3Side = 133;
B1_3Side = B2_3Side + 2 * SideB_diff;
output.Trapezium_area_3Side = ((B1_3Side+B2_3Side)/2) *Sideheight;
% ceil(output.Trapezium_area_3Side)

% Section 4
% same as section 2
A_4Side = SideHypothenuse;
B_4Side = 88.41;
output.Area_4Side = A_4Side * B_4Side; 
% ceil(output.Area_4Side)

% Section 5
B1_5Side = 203;
B2_5Side = B1_5Side - SideB_diff;
output.Trapezium_area_5Side = ((B1_5Side+B2_5Side)/2) *Sideheight;
% ceil(output.Trapezium_area_5Side)

%% Cut Top Area
depthTop = 50.8-2*depthSide;
Topdegree = 21.81;
Topheight = 4.8;

TopB_diff = tand(Topdegree)*Topheight;
TopHypothenuse = Topheight/cosd(Topdegree);

% Section 1
B1_1Top = 139;
B2_1Top = B1_1Top - TopB_diff;
output.Trapezium_area_1Top = ((B1_1Top+B2_1Top)/2)*Topheight;
% ceil(output.Trapezium_area_1Top)

% Section 2
A_2Top = TopHypothenuse;
B_2Top = 88.41;
output.Area_2Top = A_2Top * B_2Top; 
% ceil(output.Area_2Top)

% Section 3
theta_angle = 111.81;
B2_3Top = 133;
TopB_diff2 = Topheight/tand(180-theta_angle);
B1_3Top = B2_3Top + 2 * TopB_diff2;

output.Trapezium_area_3Top = ((B1_3Top+B2_3Top)/2) *Topheight;
% ceil(output.Trapezium_area_3Top)

% Section 4
% same as section 2
A_4Top = TopHypothenuse;
B_4Top = 88.41;
output.Area_4Top = A_4Top * B_4Top; 
% ceil(output.Area_4Top)

% Section 5
B1_5Top = 203;
B2_5Top = B1_5Top - TopB_diff;
output.Trapezium_area_5Top = ((B1_5Top+B2_5Top)/2) *Topheight;
% ceil(output.Trapezium_area_5Top)

%% Mass of sections
density = 2720; % kg/m.^3

% Section 1
output.Volume_1 = (2*(output.Trapezium_area_1Side*depthSide) + ...
    output.Trapezium_area_1Top*depthTop)/(1e+9);
output.Mass_1 = output.Volume_1*density;

% Section 2
output.Volume_2 = (2*(output.Area_2Side*depthSide) + ...
    output.Area_2Top*depthTop)/(1e+9);
output.Mass_2 = output.Volume_2*density;

% Section 3
output.Volume_3 = (2*(output.Trapezium_area_3Side*depthSide) + ...
    output.Trapezium_area_3Top*depthTop)/(1e+9);
output.Mass_3 = output.Volume_3*density;

% Section 4
output.Volume_4 = (2*(output.Area_4Side*depthSide) + ...
    output.Area_4Top*depthTop)/(1e+9);
output.Mass_4 = output.Volume_4*density;

% Section 5
output.Volume_5 = (2*(output.Trapezium_area_5Side*depthSide) + ...
    output.Trapezium_area_5Top*depthTop)/(1e+9);
output.Mass_5 = output.Volume_5*density;

output.TotalVolume = output.Volume_1 + output.Volume_2 + ...
    output.Volume_3 + output.Volume_4 + output.Volume_5; % m.^3

output.mass = output.Mass_1 + output.Mass_2 + ...
    output.Mass_3 + output.Mass_4 + output.Mass_5;

output.massMatrix(1,1) = (output.Mass_1)/2;
output.massMatrix(2,2) = (output.Mass_1)/2+(output.Mass_2)/2;
output.massMatrix(3,3) = (output.Mass_2)/2+(output.Mass_3)/2;
output.massMatrix(4,4) = (output.Mass_3)/2+(output.Mass_4)/2;
output.massMatrix(5,5) = (output.Mass_4)/2+(output.Mass_5)/2;
output.massMatrix(6,6) = (output.Mass_5)/2;

end