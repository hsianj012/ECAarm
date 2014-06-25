function [posAng, posPt, speed, current, POI,length] = dataForPlot(data)
%% Plot of motor positions and currents.
if (~isempty(data()))
     M = size(data,2);
     length = M;
     position = zeros(5,M);
     current = zeros(5,M);
     speed = zeros(5,M);
     
     offset_position = 6;
     offset_speed = 8;
     offset_current = 10;
     width = 9;

     for i=1:5
       for j =1:M
         % i 
         position(i,j) = 256*data(offset_position + (i-1)*width,j) + ...
              data(offset_position + (i-1)*width + 1, j);
         current(i,j) = 256*data(offset_current + (i-1)*width,j) + ...
              data(offset_current + (i-1)*width + 1, j);
         speed(i,j) = 256*data(offset_speed + (i-1)*width,j) + ...
              data(offset_speed + (i-1)*width + 1, j);
       end
     end

     posAng.shoulder = shoulderToAngle(position(1,:));
     posAng.slew = slewToAngle(position(2,:));
     posAng.elbow = elbowToAngle(position(3,:));
%      posAng.wrist = 
     posAng.jaw = jawToPercent(position(5,:));
     
     [posPt.x,posPt.y,posPt.z,POI]=angleToPoint(posAng.shoulder, posAng.slew, posAng.elbow);
     
%      hold on
%      plot(1:M, slewToAngle(position(2,:)),'-g.')
%      plot(1:M, elbowToAngle(position(3,:)),'-b.')
%      %plot(1:M, (1/scale(4))*position(4,:),'-c.')
%      %plot(1:M, (1/scale(5))*position(5,:),'-m.')
% 
%      title('Joint positions')
%      xlabel('Cycle')
%      ylabel('Position')
% 
%      legend('Shoulder', 'Slew', 'Elbow')% 'Jaw - Rotate', 'Jaw - Grip');
% 
%      figure();
%      plot(1:M, current(1,:),'-r.')
%      hold on
%      plot(1:M, current(2,:),'-g.')
%      plot(1:M, current(3,:),'-b.')
%      plot(1:M, current(4,:),'-c.')
%      plot(1:M, current(5,:),'-m.')
% 
%      title('Joint current')
%      xlabel('Cycle')
%      ylabel('Current')
% 
%      legend('Shoulder', 'Slew', 'Elbow', 'Jaw - Rotate', 'Jaw - Grip');
end