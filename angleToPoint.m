function [x,y,z] = angleToPoint(slew,shoulder,elbow)
    % This functions takes angles (in degrees) and maps it to
    % a point in cartesian coordinates

    % fixed distances <-- needs to be measured
    forarm = 8; % jaw to elbow
    midarm = 9; % elbow to shoulder
%     aftarm = 0; % shoulder to slew
    
   
    shoulderPos.r = midarm*cosd(shoulder);
    shoulderPos.z = midarm*sind(shoulder);
    
    angle = 180-elbow-shoulder;
    elbowPos.r = forarm*cosd(angle);
    elbowPos.z = -forarm*sind(angle);
    
    r.arm = shoulderPos.r + elbowPos.r;
    
    r.x = -r.arm*sind(slew);
    r.y = -r.arm*cosd(slew);
    
    
    x = r.x;
    y = r.y;
    z = shoulderPos.z + elbowPos.z;
end
    
    

