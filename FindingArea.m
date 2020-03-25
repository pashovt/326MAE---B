function output = FindingArea()
%% sides area
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

%% cut top
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