function [posAng, posPt, speed, current, temperature, length] = dataForPlot(data)
%% Plot of motor positions and currents.
if (~isempty(data()))
     M = size(data,2);
     length = M;
     position = zeros(5,M);
     current = zeros(5,M);
     speed = zeros(5,M);
     posAng = zeros(4,M);
     posPt = zeros(3,M);
     temperature = zeros(5,M);
     
     % offet/width based on position in packet and bytes for each motor
     offset_position = 6;
     offset_speed = 8;
     offset_current = 10;
     offset_temp = 12;
     width = 9;

     % Separate raw data
     for i=1:5
       for j =1:M
         % i 
         position(i,j) = data(offset_position + (i-1)*width,j) + ...
              256*data(offset_position + (i-1)*width + 1, j);
         current(i,j) = data(offset_current + (i-1)*width,j) + ...
              256*data(offset_current + (i-1)*width + 1, j);
         speed(i,j) = data(offset_speed + (i-1)*width,j) + ...
              256*data(offset_speed + (i-1)*width + 1, j);
         % convert temperature from 8-bit to Celsius (eq. from COMM manual)
         temp8bit = data(offset_temp + (i-1)*width,j);
         temperature(i,j) = ((temp8bit / 255) * 3.3) / 0.0066101694915254237288135593220339;
       end
     end

     posAng(1,:) = shoulderToAngle(position(1,:));
     posAng(2,:) = slewToAngle(position(2,:));
     posAng(3,:) = elbowToAngle(position(3,:));
%      posAng.wrist = 
     posAng(4,:) = jawToPercent(position(5,:));
     
     for k = 1:M
         [posPt(1,k),posPt(2,k),posPt(3,k)]=angleToPoint(posAng(1,k), posAng(2,k), posAng(3,k));
     end
     
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