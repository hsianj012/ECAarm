function [data] = runArm(inputType, input, demand_type)
%  [data] = runArm('angles',[90 0 0 0 0],[5 0 0 0 0]);
%runArm communicates between MATLAB and the arm. 
% inputType either 'angles','point','rotate','open'
% input is a vector with the corresponding angles (shoulder, slew, elbow),
%       cartesian point (x,y,z)

clc

demand_raw = zeros(1,5);
%% Establish destination
switch lower(inputType)
    case {'angles','angle'}
        demand_raw(1) = angleToShoulder(input(1));
        demand_raw(2) = angleToSlew(input(2));
        demand_raw(3) = angleToElbow(input(3));
    case {'point','points'}
        [shoulder,slew,elbow] = pointToAngle(input(1),input(2),input(3));
        demand_raw(1) = angleToShoulder(shoulder);
        demand_raw(2) = angleToSlew(slew);
        demand_raw(3) = angleToElbow(elbow);    
end

if input(5)
    demand_raw(5) = percentToJaw(input(5));
end


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
offset_speed = 8;
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
percent_tolerance = 5;
% angle_tolerance = 0.5;
k = 1;
tries = 0;

t_cycle = 0.05;

% set demand type to position for all non-jaw motors
% demand_type = [5 5 5 0 0];


% set demand values for first waypoint
for m=1:5
    if demand_type(m) ~= 0
        demand(m) = toDemand(demand_raw(m));
    else
        demand(m) = 0;
    end
end

% demand

while(i < N)
    %---- possibly add stop button catch here---%
    
   % create command
   command = getMotorDemandCommand(demand_type, demand, speed_limit,current_limit);
   % send command to serial port
   fwrite(s, command);

   % wait
   pause(t_cycle)

   % 2 - sense
   if 0 < s.BytesAvailable
     data = [data, fread(s,s.BytesAvailable,'uint8')];
%      t = [t, (toc-t0)];
     % record position from received packet
     for j=1:5
         position(j,i) = data(offset_position + (j-1)*width,i) + ...
             256*data(offset_position + (j-1)*width + 1, i);
%          position(j,i) = 256*(offset_position + (j-1)*width + 1) + ...
%              data(offset_position + (j-1)*width,i);
     end

     % convert received position to angles
     alpha_m = shoulderToAngle(position(1,i));
     gamma_m = slewToAngle(position(2,i));
     beta_m = elbowToAngle(position(3,i));
%      delta_m = wristToAngle(position(4,i)); % To be written
     epsilon_m = jawToPercent(position(5,i));
     
     % print out progress in command window
     disp(' ');
     disp(['      at: alpha=', num2str(alpha_m),...
           ' gamma=', num2str(gamma_m),...
           ' beta=', num2str(beta_m),...
           ' epsilon=', num2str(epsilon_m)]);
%            ' delta=', num2str(delta_m),...
%            ' epsilon=', num2str(epsilon_m)]);
     disp(['going to: alpha=', num2str(shoulderToAngle(demand_raw(1))), ...
           ' gamma=', num2str(slewToAngle(demand_raw(2))),...
           ' beta=', num2str(elbowToAngle(demand_raw(3))),...
           ' epsilon=', num2str(jawToPercent(demand_raw(5))),' ']);
%            ' delta=', num2str(wristToAngle(demand_raw(4))),...
%            ' epsilon=', num2str(jawToPercent(demand_raw(5))),' ']);

     % check progress
     
     
     % if within tolerance, stop that motor
     alpha_error = deg2rad(shoulderToAngle(demand_raw(1))) - deg2rad(alpha_m);
     if( abs(alpha_error) < angle_tolerance)
         demand_type(1) = 0;
     end

     gamma_error = deg2rad(slewToAngle(demand_raw(2))) - deg2rad(gamma_m);
     if( abs(gamma_error) < angle_tolerance)
         demand_type(2) = 0;
     end

     beta_error = deg2rad(elbowToAngle(demand_raw(3))) - deg2rad(beta_m);
     if( abs(beta_error) < angle_tolerance)
         demand_type(3) = 0;
     end

% %
%      delta_error = wristToAngle(demand_raw(4)) - delta_m;
%      if( abs(delta_error) < angle_tolerance)
%          demand_type(4) = 0;
%      end

     epsilon_error = jawToPercent(demand_raw(5)) - epsilon_m;
     if( abs(epsilon_error) < percent_tolerance)
         demand_type(5) = 0;
     end

     if (min(demand_type == zeros(1,5)) == 1 )
        % we've arrived, get the next waypoint.
        demand = [0 0 0 0 0];
%         demand_type = [5 5 5 0 5];
        k = k + 1;

        if (k>size(demand_raw,2))
            disp('Completed.')
            break;
        end
%         disp('-----------------------------------------');
%         disp([' Going to waypoint ', num2str(k)])
%         disp(['alpha=', num2str(rad2deg(alpha(k))),... 
%             ' gamma=', num2str(rad2deg(gamma(k))),... 
%             ' beta=', num2str(rad2deg(beta(k))), ' ']);
%         disp('-----------------------------------------');
%         %pause(1)
% 
%          % check if any of the joints is already at its target value.
% 
%          alpha_error = alpha(k) - deg2rad(alpha_m);
%          if( abs(alpha_error) < angle_tolerance)
%              demand_type(1) = 0;
%          end
% 
%          gamma_error = gamma(k) - deg2rad(gamma_m);
%          if( abs(gamma_error) < angle_tolerance)
%              demand_type(2) = 0;
%          end
% 
%          beta_error = beta(k) - deg2rad(beta_m);
%          if( abs(beta_error) < angle_tolerance)
%              demand_type(3) = 0;
%          end
% 
%         alpha_command = toDemand(angleToShoulder(rad2deg(alpha(k))));
%         gamma_command = toDemand(angleToSlew(rad2deg(gamma(k))));
%         beta_command = toDemand(angleToElbow(rad2deg(beta(k))));
% 
%         demand = [ alpha_command gamma_command beta_command 0 0];
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

%%

% disp('Made it to the end')

fclose(s)
delete(s)
clear s

end

