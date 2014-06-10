function [p0,p1] = angleToPoint2(slew,shoulder,elbow)
    % This functions takes angles (in degrees) and maps it to
    % a point in cartesian coordinates

    % fixed distances <-- needs to be measured
    forarm = 8; % jaw to elbow
    midarm = 9; % elbow to shoulder
%     aftarm = 0; % shoulder to slew
    
    % Fixed by nature of motor orientation
    
    
    
    shoulderPos.r = midarm*cosd(shoulder);
    p0(1) = -shoulderPos.r*sind(slew);
    p0(2) = -shoulderPos.r*cosd(slew);
    
    p0(3) = midarm*sind(shoulder);
    
    angle = 180-elbow-shoulder;
    elbowPos.r = forarm*cosd(angle);
    p1(3) = -forarm*sind(angle);
    
    p1(1) = -elbowPos.r*sind(slew);
    p1(2) = -elbowPos.r*cosd(slew);
    

end
    
    

