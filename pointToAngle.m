function [slew, shoulder, elbow] = pointToAngle(x,y,z)

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

    CE = sqrt(forearm^2 + CD^2);
    AC = 9+(5/32);
    
    
    %% physical limits of arm
%     MINshould = 0;
%     MAXshould = 90;
%     MINelbow = 0;
%     MAXelbow = 130;

    %% angles
    slew = atand(x/y);
    
    r = sqrt(x^2 + y^2)-3;
    l = sqrt(r^2 + z^2);
    
    CAE = acosd((CE^2 - AC^2 - l^2)/(-2*AC*l));
    BAC = acosd((BC^2 - bicep^2 - AC^2)/(-2*bicep*AC));
    shoulder = CAE + BAC + atand(z/r);
    
    CEA = acosd((AC^2 - l^2 - CE^2)/(-2*l*CE));
    DEC = atand(CD/forearm);
    elbow = 180 - (CEA + DEC + CAE + BAC);
end



