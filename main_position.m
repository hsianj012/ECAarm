clc
clear all

close all

% load('motor_angles4.mat')
% alpha = deg2rad(alpha);% + deg2rad(10);
% gamma = deg2rad(5 + 0.1*gamma);% + deg2rad(15);
% beta = deg2rad(beta+140); %+ deg2rad(140);

% alpha = alpha(1:10:end);
% gamma = gamma(1:10:end);
% beta = beta(1:10:end);

%% Establish waypoints
% alpha = deg2rad([10,20,30]); % shoulder
% gamma = deg2rad([10, 20, 30, 40, 30, 20, 10]); % Slew
% beta = deg2rad([10, 20, 30, 40, 30, 20, 10]); % Elbow
epsilon = [50 40 30 20 10];
% % figure()
% % plot(rad2deg(alpha), '-r.')
% % hold on
% % plot(rad2deg(gamma), '-g.')
% % plot(rad2deg(beta),'-b.')
% % legend('Shoulder', 'Slew', 'Elbow');
% % ylabel('Degrees')
% % title('Waypoints')
% % pause



%% Move arm along waypoints

% set up connection to arm
s = serial('COM2'); % '\dev\tty.usb'
set(s,'BaudRate',115200)
set(s,'ByteOrder','bigEndian')
get(s)

fopen(s);

N = 500;

data = [];
position = zeros(5, N);

% scaling factors in pulses per radian
% shoulder = alpha = motor 1
% slew = gamma = motor 2
% elbow = beta = motor 3

offset_position = 6;
offset_current = 10;
width = 9;

% -- Limits of motors --
speed_limit = 4095*ones(1,5);
% speed_limit = 2047*ones(1,5);
current_limit = 4095*ones(1,5);
% current_limit = 2047*ones(1,5);


i = 1;
positioning_tolerance = 300;
angle_tolerance = deg2rad(0.5);
jaw_tolerance = 5;
k = 1;
tries = 0;

t_cycle = 0.05;

% set demand type to position for all non-jaw motors
% demand_type = [5 5 5 0 0];
demand_type = [0 0 0 0 5];
% set demand values for first waypoint
% demand = [  toDemand(angleToShoulder(rad2deg(alpha(1)))),...
%              toDemand(angleToSlew(rad2deg(gamma(1)))),...
%              toDemand(angleToElbow(rad2deg(beta(1)))),...
%              0 0];

% demand = [  toDemand(angleToShoulder(rad2deg(alpha(1)))),0,0,0,0];
demand = [0,0,0,0,toDemand(percentToJaw(epsilon(1)))];

while(i < N)
   % command
   command = getMotorDemandCommand(demand_type, demand, speed_limit,current_limit);
   % sends command to serial port
   fwrite(s, command);

   % wait
   pause(t_cycle)

   % 2 - sense
   if 0 < s.BytesAvailable
     data = [data, fread(s,s.BytesAvailable,'uint8')];
     %t = [t, (toc-t0)];
     for j=1:5
         position(j,i) = data(offset_position + (j-1)*width,i) + ...
             256*data(offset_position + (j-1)*width + 1, i);
     end

     alpha_m = shoulderToAngle(position(1,i));
     gamma_m = slewToAngle(position(2,i));
     beta_m = elbowToAngle(position(3,i));
     epsilon_m = jawToPercent(position(5,i));
     
     disp(' ');
     disp(['at: epsilon=', num2str(epsilon_m)]);
%          'at: alpha=', num2str(alpha_m)])%,...
%            ' gamma=', num2str(gamma_m),...
%            ' beta=', num2str(beta_m)]);
     disp(['going to: epsilon=', num2str(epsilon(k))]);
%      ['going to: alpha=', num2str(rad2deg(alpha(k)))])%, ...
%            ' gamma=', num2str(rad2deg(gamma(k))),...
%            ' beta=', num2str(rad2deg(beta(k))), ' ']);

%      alpha_error = alpha(k) - deg2rad(alpha_m);
%      if( abs(alpha_error) < angle_tolerance)
%          demand_type(1) = 0;
%      end

%      gamma_error = gamma(k) - deg2rad(gamma_m);
%      if( abs(gamma_error) < angle_tolerance)
%          demand_type(2) = 0;
%      end
% 
%      beta_error = beta(k) - deg2rad(beta_m);
%      if( abs(beta_error) < angle_tolerance)
%          demand_type(3) = 0;
%      end
     epsilon_error = epsilon(k) - epsilon_m;
     if( abs(epsilon_error) < jaw_tolerance)
         demand_type(5) = 0;
     end

     if (min(demand_type == zeros(1,5)) == 1 )
        % we've arrived, get the next waypoint.
        demand = [ 0 0 0 0 0];
%         demand_type = [5 5 5 0 0];
        demand_type = [ 0 0 0 0 5];
        k = k + 1;

        if (k>size(epsilon,2))
            disp('Completed.')
            break;
        end
        disp('-----------------------------------------');
        disp([' Going to waypoint ', num2str(k)])
        disp(['epsilon=', num2str(epsilon(k))])%,... 
%             ' gamma=', num2str(rad2deg(gamma(k))),... 
%             ' beta=', num2str(rad2deg(beta(k))), ' ']);
        disp('-----------------------------------------');
        %pause(1)

         % check if any of the joints is already at its target value.

             epsilon_error = epsilon(k) - epsilon_m;
             if( abs(epsilon_error) < jaw_tolerance)
                 demand_type(5) = 0;
             end
%          alpha_error = alpha(k) - deg2rad(alpha_m);
%          if( abs(alpha_error) < angle_tolerance)
%              demand_type(1) = 0;
%          end

%          gamma_error = gamma(k) - deg2rad(gamma_m);
%          if( abs(gamma_error) < angle_tolerance)
%              demand_type(2) = 0;
%          end
% 
%          beta_error = beta(k) - deg2rad(beta_m);
%          if( abs(beta_error) < angle_tolerance)
%              demand_type(3) = 0;
%          end

%         alpha_command = toDemand(angleToShoulder(rad2deg(alpha(k))));
%         gamma_command = toDemand(angleToSlew(rad2deg(gamma(k))));
%         beta_command = toDemand(angleToElbow(rad2deg(beta(k))));
          epsilon_command = toDemand(percentToJaw(epsilon(k)));
%         demand = [ alpha_command gamma_command beta_command 0 0];
        demand = [ 0 0 0 0 epsilon_command];
     end
     tries = 0;
   else
       disp('No reply from arm')
       tries = tries + 1;
       if (tries > 50)
           disp('Quitting.')
           break;
       end
   end

   % 3 control
   %lolno

   i=i+1;
%   disp('.');
end
%toc
%{
figure();
plot(1:N, position(1,:),'r')
hold on
plot(1:N, position(1,:),'g')
plot(1:N, position(1,:),'b')
plot(1:N, position(1,:),'c')
plot(1:N, position(1,:),'m')
%}


%% Plot of motor positions and currents.
if (~isempty(data()))
     M = size(data,2);
     position = zeros(5,M);
     current = zeros(5,M);

     for i=1:5
       for j =1:M
         position(i,j) = data(offset_position + (i-1)*width,j) + ...
             256*data(offset_position + (i-1)*width + 1, j);
         current(i,j) = data(offset_current + (i-1)*width,j) + ...
              256*data(offset_current + (i-1)*width + 1, j);
         %position(i,j) = data(offset_position + (i-1)*width + 1, j);
         %current(i) = 256*command(offset_current + (i-1)*width) + command(offset_current + (i-1)*width + 1);
       end
     end

     %close all;

     figure();
     
%      plot(1:M, shoulderToAngle(position(1,:)),'-r.')
%      hold on
%      plot(1:M, slewToAngle(position(2,:)),'-g.')
%      plot(1:M, elbowToAngle(position(3,:)),'-b.')
     %plot(1:M, (1/scale(4))*position(4,:),'-c.')
     %plot(1:M, (1/scale(5))*position(5,:),'-m.')
     plot(1:M, jawToPercent(position(5,:)))

     title('Joint positions')
     xlabel('Cycle')
     ylabel('Position')

     legend('Shoulder', 'Slew', 'Elbow')% 'Jaw - Rotate', 'Jaw - Grip');

     figure();
     plot(1:M, current(1,:),'-r.')
     hold on
     plot(1:M, current(2,:),'-g.')
     plot(1:M, current(3,:),'-b.')
     plot(1:M, current(4,:),'-c.')
     plot(1:M, current(5,:),'-m.')

     title('Joint current')
     xlabel('Cycle')
     ylabel('Current')

     legend('Shoulder', 'Slew', 'Elbow', 'Jaw - Rotate', 'Jaw - Grip');
end

%%

% disp('Made it to the end')

fclose(s)
delete(s)
clear s