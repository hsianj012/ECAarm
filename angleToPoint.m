function [x,y,z] = angleToPoint(slew,shoulder,elbow)
    % This functions takes angles (in degrees) and maps it to
    % a point in cartesian coordinates

    % fixed distances <-- needs to be measured
    forarm = 8; % jaw to elbow
    midarm = 9; % elbow to shoulder
    aftarm = 10; % shoulder to slew
    
    % Fixed by nature of motor orientation
    slewPos.z = 0;
    
    shoulderPos.r = midarm*cosd(shoulder);
    shoulderPos.z = midarm*sind(shoulder);
    
    angle = elbow+shoulder-90;
    elbowPos.r = sind(angle)*forarm;
    elbowPos.z = -cosd(angle)*forarm;
    

    
    r.arm = aftarm + shoulderPos.r + elbowPos.r;
    
    r.x = -r.arm*sind(slew);
    r.y = -r.arm*cosd(slew);
    
    
    x = r.x;
    y = r.y;
    z = slewPos.z + shoulderPos.z + elbowPos.z;
end
    
    

