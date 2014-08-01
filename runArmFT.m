function [data] = runArmFT(input, demand_type)
%runArm communicates between MATLAB and the arm. 
% input is a 5xN matrix of waypoint

% clc

% % demand_raw = zeros(5,size(input,2));
% % %% Establish destination
% % for j = 1:size(input,2)
% %     demand_raw(1,j) = angleToShoulder(input(1,j));
% %     demand_raw(2,j) = angleToSlew(input(2,j));
% %     demand_raw(3,j) = angleToElbow(input(3,j));
% %     demand_raw(5,j) = percentToJaw(input(5,j));
% % end

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
% offset_speed = 8;
% offset_current = 10;
width = 9;

% -- Limits of motors --
speed_limit = 4095*ones(1,5);
% speed_limit = 2047*ones(1,5);
current_limit = 4095*ones(1,5);
% current_limit = 2047*ones(1,5);


i = 1;
% positioning_tolerance = 300;
angle_tolerance = deg2rad(0.5);
percent_tolerance = 4;
% angle_tolerance = 0.5;
k = 1;
tries = 0;

t_cycle = 0.05;

% set demand type to position for all non-jaw motors
% demand_type = [5 5 5 0 0];

% demand = zeros(1,5);
% % set demand values for first waypoint
% for m=1:5
%     demand(m) = toDemand(demand_raw(m,k));
% end

% demand

% while(i < N)
    %---- possibly add stop button catch here---%
%    myfilename = sprintf('FTData_%d.lvm', i);
%    [Fx, Fy, Fz, Tx, Ty, Tz] = lvmToFT(myfilename,'T','series');
%    Fz = [-10*ones(1,10),zeros(1,20)];
%    if (i<length(Fz))
%         if Fz(i) < -5
%             command = getMotorDemandCommand([2 0 0 0 0], [100 0 0 0 0], speed_limit,current_limit);
%         end
%    else
   % create command
   command = getMotorDemandCommand(demand_type, input, speed_limit,current_limit);
   % send command to serial port
%    end
   
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

     disp(['going to: alpha=', num2str(input(1,k)), ...
           ' gamma=', num2str(input(2,k)),...
           ' beta=', num2str(input(3,k)),...
           ' epsilon=', num2str(input(5,k)),' ']);
%            ' delta=', num2str(wristToAngle(demand_raw(4))),...
%            ' epsilon=', num2str(jawToPercent(demand_raw(5))),' ']);

     % check progress
     
% %      
% %      % if within tolerance, stop that motor
% %      alpha_error = deg2rad(shoulderToAngle(demand_raw(1,k))) - deg2rad(alpha_m);
% %      if( abs(alpha_error) < angle_tolerance)
% %          demand_type(1) = 0;
% %      end
% % 
% %      gamma_error = deg2rad(slewToAngle(demand_raw(2,k))) - deg2rad(gamma_m);
% %      if( abs(gamma_error) < angle_tolerance)
% %          demand_type(2) = 0;
% %      end
% % 
% %      beta_error = deg2rad(elbowToAngle(demand_raw(3,k))) - deg2rad(beta_m);
% %      if( abs(beta_error) < angle_tolerance)
% %          demand_type(3) = 0;
% %      end
% % 
% % % %
% % %      delta_error = wristToAngle(demand_raw(4)) - delta_m;
% % %      if( abs(delta_error) < angle_tolerance)
% % %          demand_type(4) = 0;
% % %      end
% % 
% %      epsilon_error = jawToPercent(demand_raw(5,k)) - epsilon_m;
% %      if( abs(epsilon_error) < percent_tolerance)
% %          demand_type(5) = 0;
% %      end

% %      if (min(demand_type == zeros(1,5)) == 1 )
% %         % we've arrived, get the next waypoint.
% %         demand = [0 0 0 0 0];
% %         demand_type = [5 5 5 0 0];
% %         k = k + 1;
% % 
% %         if (k>size(demand_raw,2))
% %             disp('Completed.')
% %             return;
% %         end
% %         disp('-----------------------------------------');
% %         disp([' Going to waypoint ', num2str(k)])
% %         disp(['alpha=', num2str(input(1,k)), ...
% %            ' gamma=', num2str(input(2,k)),...
% %            ' beta=', num2str(input(3,k)),...
% %            ' epsilon=', num2str(input(5,k)),' ']);
% %         disp('-----------------------------------------');
% % %         %pause(1)
% % % 
% %          % check if any of the joints is already at its target value.
% % 
% %          alpha_error = deg2rad(shoulderToAngle(demand_raw(1,k))) - deg2rad(alpha_m);
% %          if( abs(alpha_error) < angle_tolerance)
% %              demand_type(1) = 0;
% %          end
% % 
% %          gamma_error = deg2rad(slewToAngle(demand_raw(2,k))) - deg2rad(gamma_m);
% %          if( abs(gamma_error) < angle_tolerance)
% %              demand_type(2) = 0;
% %          end
% % 
% %          beta_error = deg2rad(elbowToAngle(demand_raw(3,k))) - deg2rad(beta_m);
% %          if( abs(beta_error) < angle_tolerance)
% %              demand_type(3) = 0;
% %          end
% % 
% %          epsilon_error = jawToPercent(demand_raw(5,k)) - epsilon_m;
% %          if( abs(epsilon_error) < percent_tolerance)
% %              demand_type(5) = 0;
% %          end
% %          
% %          % get demand values for new waypoint
% %          for m=1:5
% %              demand(m) = toDemand(demand_raw(m,k));
% %          end
% % %          disp(demand)
% %      end
     tries = 0;
   else
       disp('No reply from arm')
       tries = tries + 1;
       if (tries > 20)
           disp('Quitting.')
           return;
       end
   end

   % 3 control
   %lolno

   i=i+1;
%   disp('.');
% end
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

