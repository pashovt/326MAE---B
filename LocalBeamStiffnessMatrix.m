function beamMatrix = LocalBeamStiffnessMatrix(A, L, I, E, deg)
% Calculates the local matrix for a beam using the provided formula
% StiffMatrix = imread("RodBeamGlobal.png");
% imshow(StiffMatrix)
%
% Expected inputs for a single element of the beam
    % A - Area of the element
    % L - Length of the element
    % I - Second moment of Inertia of the beam cross section
    % deg - Degree at which the element is tilted
% 
% Returns a the assembled local stiffness matrix

beamMatrix = zeros(6, 6);

% Variables for the specific local element
c = cos(deg);
s = sin(deg);

a = (E*A)/L;
b = (12*E*I)/(L.^3);

kk = (6*E*I)/(L.^2);
ii = (4*E*I)/L;
jj = (2*E*I)/L;


beamMatrix(1,1) = a*c.^2 + b*s.^2;
beamMatrix(1,2) = a*c*s - b*c*s;
beamMatrix(1,3) = -kk*s;
beamMatrix(1,4) = -a*c.^2 - b*s.^2;
beamMatrix(1,5) = -a*c*s + b*c*s;
beamMatrix(1,6) = -kk*s;

beamMatrix(2,1) = a*c*s - b*c*s;
beamMatrix(2,2) = a*s.^2 + b*c.^2;
beamMatrix(2,3) = kk*c;
beamMatrix(2,4) = -a*c*s + b*c*s;
beamMatrix(2,5) = -a*s.^2 - b*c.^2;
beamMatrix(2,6) = kk*c;

beamMatrix(3,1) = -kk*s;
beamMatrix(3,2) = kk*c;
beamMatrix(3,3) = ii;
beamMatrix(3,4) = kk*s;
beamMatrix(3,5) = -kk*c;
beamMatrix(3,6) = jj;

beamMatrix(4,1) = -a*c.^2 - b*s.^2;
beamMatrix(4,2) = -a*c*s + b*c*s;
beamMatrix(4,3) = kk*s;
beamMatrix(4,4) = a*c.^2 + b*s.^2;
beamMatrix(4,5) = a*c*s - b*c*s;
beamMatrix(4,6) = kk*s;

beamMatrix(5,1) = -a*c*s + b*c*s;
beamMatrix(5,2) = -a*s.^2 - b*c.^2;
beamMatrix(5,3) = -kk*c;
beamMatrix(5,4) = a*c*s - b*c*s;
beamMatrix(5,5) = a*s.^2 + b*c.^2;
beamMatrix(5,6) = -kk*c;

beamMatrix(6,1) = -kk*s;
beamMatrix(6,2) = kk*c;
beamMatrix(6,3) = jj;
beamMatrix(6,4) = kk*s;
beamMatrix(6,5) = -kk*c;
beamMatrix(6,6) = ii;

end