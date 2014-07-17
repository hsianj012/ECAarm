function [ newWaypoints ] = makeWaypoint( waypoints )
%makeWaypoint Creates waypoint(s) to destination
%   Checks current waypoints (including initial position) and adds
%   intermediate waypoints as needed.

% Range limits of each joint
max = [90 120 130 2000 100]'; % [shoulder, slew, elbow, wrist, jaw]

% initial position of arm
initPos = getInitPosition; 

% get number of waypoints
M = size(waypoints,2);

% add start position to beginning of waypoints
waypoints = [initPos, waypoints];
newWaypoints = [];

j = 1;

% check each pair of waypoints
for i = 1:M
    start = waypoints(:,i);
    desired = waypoints(:,i+1);
    
    % compare waypt(i) and waypt(i+1)
    diff = abs(start-desired);
    valid = diff < .5*max;
    if valid
        disp('valid')
        newWaypoints(1:5,j) = desired;
        j=j+1;
    else
        for k = 1:5
            if valid(k)
                newWaypoints(k,j) = desired(k);
                newWaypoints(k,j+1) = desired(k);
            else
                newWaypoints(k,j) = mean([desired(k), start(k)]);
                newWaypoints(k,j+1) = desired(k);
            end
        end
        j=j+2;
    end
end

end

