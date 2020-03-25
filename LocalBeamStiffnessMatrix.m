function beamMatrix = LocalBeamStiffnessMatrix(A, L, I, deg)
beamMatrix = zeros(6, 6);
% variables
E = 68.9*10.^3; % 68.9 GPa
% A = 1;
% L = 1;
% I = 1;
c = cos(deg);
s = sin(deg);


%% Top right
% Top right block
beamMatrix(1,1) = ((E*A)/L)*c.^2 + ((12*E*I)/L.^3)*s.^2;
beamMatrix(1,2) = ((E*A)/L)*c*s - ((12*E*I)/L.^3)*c*s;
beamMatrix(2,1) = beamMatrix(1,2); % ((E*A)/L)*c*s - ((12*E*I)/L.^3)*c*s
beamMatrix(2,2) = ((E*A)/L)*s.^2 + ((12*E*I)/L.^3)*c.^2;

% Top right remaining
beamMatrix(3,1) = -((6*E*I)/L.^2)*s;
beamMatrix(3,2) = ((6*E*I)/L.^2)*c;
beamMatrix(3,3) = (4*E*I)/L;
beamMatrix(1,3) = beamMatrix(3,1); % -((6*E*I)/L.^2)*s
beamMatrix(2,3) = beamMatrix(3,2); % ((6*E*I)/L.^2)*c


%% Top left
% Top left block
beamMatrix(1,4) = -((E*A)/L)*c.^2 - ((12*E*I)/L.^3)*s.^2;
beamMatrix(1,5) = -((E*A)/L)*c*s + ((12*E*I)/L.^3)*c*s;
beamMatrix(2,4) = beamMatrix(1,5); % -((E*A)/L)*c*s + ((12*E*I)/L.^3)*c*s
beamMatrix(2,5) = -((E*A)/L)*s.^2 - ((12*E*I)/L.^3)*c.^2;

% Top left remaining
beamMatrix(3,4) = -beamMatrix(3,1); % ((6*E*I)/L.^2)*s
beamMatrix(3,5) = -beamMatrix(3,2); % -((6*E*I)/L.^2)*c
beamMatrix(3,6) = (2*E*I)/L;
beamMatrix(1,6) = -beamMatrix(3,4); % -((6*E*I)/L.^2)*s
beamMatrix(2,6) = -beamMatrix(3,5); % ((6*E*I)/L.^2)*c


%% Bottom right
% Bottom right block
beamMatrix(4,1) = beamMatrix(1,4); % -((E*A)/L)*c.^2 - ((12*E*I)/L.^3)*s.^2
beamMatrix(4,2) = beamMatrix(1,5); % -((E*A)/L)*c*s + ((12*E*I)/L.^3)*c*s
beamMatrix(5,1) = beamMatrix(2,4); % -((E*A)/L)*c*s + ((12*E*I)/L.^3)*c*s
beamMatrix(5,2) = beamMatrix(2,5); % -((E*A)/L)*s.^2 - ((12*E*I)/L.^3)*c.^2

% Bottom right remaining
beamMatrix(6,1) = beamMatrix(3,1); % -((6*E*I)/L.^2)*s
beamMatrix(6,2) = beamMatrix(3,2); % ((6*E*I)/L.^2)*c
beamMatrix(6,3) = beamMatrix(3,6); % (2*E*I)/L
beamMatrix(4,3) = -beamMatrix(6,1); % ((6*E*I)/L.^2)*s
beamMatrix(5,3) = -beamMatrix(6,2); % -((6*E*I)/L.^2)*c

%% Bottom left
% Bottom left block
beamMatrix(4,4) = beamMatrix(1,1); % ((E*A)/L)*c.^2 + ((12*E*I)/L.^3)*s.^2
beamMatrix(4,5) = beamMatrix(1,2); % ((E*A)/L)*c*s - ((12*E*I)/L.^3)*c*s
beamMatrix(5,4) = beamMatrix(2,1); % ((E*A)/L)*c*s - ((12*E*I)/L.^3)*c*s
beamMatrix(5,5) = beamMatrix(2,2); % ((E*A)/L)*s.^2 + ((12*E*I)/L.^3)*c.^2

% Bottom left remaining
beamMatrix(6,4) = beamMatrix(3,4); % ((6*E*I)/L.^2)*s
beamMatrix(6,5) = beamMatrix(3,5); % -((6*E*I)/L.^2)*c
beamMatrix(6,6) = beamMatrix(3,3); % (4*E*I)/L
beamMatrix(4,6) = beamMatrix(6,4); % ((6*E*I)/L.^2)*s
beamMatrix(5,6) = beamMatrix(6,5); % -((6*E*I)/L.^2)*c

end