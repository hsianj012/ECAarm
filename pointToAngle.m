function [slew, shoulder, elbow] = pointToAngle(x,y,z)

    % fixed distances <-- needs to be measured
    forarm = 8; % jaw to elbow
    midarm = 9; % elbow to shoulder
%     aftarm = 0; % shoulder to slew
    
    % physical limits of arm
%     MINshould = 0;
%     MAXshould = 90;
%     MINelbow = 0;
%     MAXelbow = 130;

    slew = atand(x/y);
    
    r = sqrt(x^2 + y^2);
    l = sqrt(r^2 + z^2);
    % shoulder 
%     minshoulder = atand(z,r);
    
    shoulder = atand(z/r) + acosd((forarm^2 - midarm^2 - l^2)/(-2*midarm*l));
    elbow = acosd((l^2 - midarm^2 - forarm^2)/(-2*midarm*forarm));
end