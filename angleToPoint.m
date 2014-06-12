function [varargout] = angleToPoint(slew,shoulder,elbow)
    % This functions takes angles (in degrees) and maps it to
    % a point in cartesian coordinates

    %% Points of Interest
    % O = origin or slew pivot pt
    % A = shoulder pivot pt
    % B = end of "bicep"
    % C = elbow pivot pt
    % D = start of forearm
    % E = end of forarm/middle of jaw
    
    
    % Distances between POI
    OA = 3.5;
    bicep = 9; % distace AB
    BC = 2.25;
    CD = 3;
    forearm = 10.5; % distance DE
    
    %% Determine (r,z) for each POI
    O.r = 0; O.z = 0;
    
    A.r = OA; A.z = 0;
    
    B.r = bicep*cosd(shoulder);
    B.z = bicep*sind(shoulder);
    
    % angle ABC - law of cosines
    AC = 9+(5/32);
    phi = acosd((AC^2 - bicep^2 - BC^2)/(-2*bicep*BC));
    
    thetaC = 180-shoulder-phi;
    C.r = BC*cosd(thetaC);
    C.z = -BC*sind(thetaC);
    
    thetaD = 90-shoulder-elbow;
    D.r = CD*cosd(thetaD);
    D.z = -CD*sind(thetaD);
    
    thetaElbow = 180-elbow-shoulder;
    E.r = forearm*cosd(thetaElbow);
    E.z = -forearm*sind(thetaElbow);
    
    r.arm = O.r + A.r + B.r + C.r + D.r +E.r;
    
    r.x = r.arm*sind(slew);
    r.y = r.arm*cosd(slew);
    
    nOutputs = nargout;
    varargout = cell(1,nOutputs);
    varargout{1} = r.x; %x
    varargout{2} = r.y; %y
    varargout{3} = O.z + A.z + B.z + C.z + D.z +E.z;%z
    varargout{4} = [O,A,B,C,D,E]; %POI
end
    
    

