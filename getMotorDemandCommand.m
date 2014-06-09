function command = getMotorDemandCommand(demand_type, demand, speed_limit, current_limit)
%   disp('Inside getMDC func')
  header = uint8([hex2dec('E7'),hex2dec('00'),hex2dec('00'),hex2dec('00')]);
  footer = uint8(hex2dec('E5'));
 
  command = header;
  
  % generate motor demand message for each motor and append to command
  for i=1:5
    %disp('made it to for loop')
    %i
    command = [command, getMotorDemandMessage(demand_type(i), demand(i), speed_limit(i), current_limit(i))];
  end

  checksum = mod(sum(command(1:49)),255)-floor(sum(command(1:49))/255);

  command = [command, checksum, footer];

end