function command = getMotorDemandCommand(demand_type, demand, speed_limit, current_limit)

  header = uint8([hex2dec('E7'),hex2dec('00'),hex2dec('00'),hex2dec('00')]);
  footer = uint8(hex2dec('E5'));
 
  command = header;
 
  for i=1:5
    command = [command, getMotorDemandMessage(demand_type(i), demand(i), speed_limit(i), current_limit(i))];
  end

  checksum = mod(sum(command(1:49)),255)-floor(sum(command(1:49))/255);

  command = [command, checksum, footer];

end