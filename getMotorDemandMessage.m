function message = getMotorDemandMessage(demand_type, demand, speed_limit, current_limit)

        message = zeros(1, 9);

        % demand type
        % 0 = hold      
        % 1 = voltage (%PWM), CW  [16bit, 0-100]
        % 2 = voltage (%PWM), CCW [16bit, 0-100]
        % 3 = speed (rpm), CW [12bit, 0-4095]
        % 4 = speed (rpm), CCW [12bit, 0-4095]
        % 5 = position [16bit]
  if (false == isinteger(demand_type))
    message(2) = 0;
  end
 
  if ( (1==demand_type) || (2==demand_type) )
    % demand range is 0-100
    demand = max(0, min(100, demand));
    % convert to 16-bit
    demand = dec2hex(int16(max(0,(demand*(2^16/100)-1))));
    message(2) = demand_type;
    switch size(demand,2)
        case (1)
            message(3) = uint8(0);
            message(4) = uint8(hex2dec(demand));
        case (2)
            message(3) = uint8(0);
            message(4) = uint8(hex2dec(demand));
        case (3)
            message(3) = uint8(hex2dec(demand(1)));
            message(4) = uint8(hex2dec(demand(2:3)));
        case (4)
            message(3) = uint8(hex2dec(demand(1:2)));
            message(4) = uint8(hex2dec(demand(3:4)));
        otherwise
            disp('Error: something went wrong!');
    end  
  elseif ( (3==demand_type) || (4==demand_type) )
    message(2) = demand_type;
    % demand range is 0-4095
    demand = uint16(max(0, min(4095, demand)));
    % no need to scale: a number between 0 and 4095 is 12bit at  most
    demand = dec2hex(demand);
    switch size(demand,2)
        case (1)
            message(3) = uint8(0);
            message(4) = uint8(hex2dec(demand));
        case (2)
            message(3) = uint8(0);
            message(4) = uint8(hex2dec(demand));
        case (3)
            message(3) = uint8(demand(1));
            message(4) = uint8(hex2dec(demand(2:3)));
        %case (4)
            % should never get here!
            %message(3) = uint8(demand(1:2));
            %message(4) = uint8(hex2dec(demand(3:4)));
        otherwise
            disp('Error: something went wrong!');
    end
  elseif ( 5 == demand_type )
    message(2) = demand_type;
    % demand is 16 bit
    demand = uint16(max(0, min(2^16-1, demand)));
    demand = dec2hex(demand);
    switch size(demand,2)
        case (1)
            message(3) = uint8(0);
            message(4) = uint8(hex2dec(demand));
        case (2)
            message(3) = uint8(0);
            message(4) = uint8(hex2dec(demand));
        case (3)
            message(3) = uint8(hex2dec(demand(1)));
            message(4) = uint8(hex2dec(demand(2:3)));
        case (4)
            message(3) = uint8(hex2dec(demand(1:2)));
            message(4) = uint8(hex2dec(demand(3:4)));
        otherwise
            disp('Error: something went wrong!');
    end
  else
      message(4) = uint8(0);
      message(5) = uint8(0);
  end
 
  % speed limit
  speed_limit = max(0, min(4095, speed_limit));
  s = dec2hex(speed_limit);
  switch size(s,2)
    case (1)
        message(5) = uint8(0);
        message(6) = uint8(hex2dec(s));
    case (2)
        message(5) = uint8(0);
        message(6) = uint8(hex2dec(s));
    case (3)
        message(5) = uint8(hex2dec(s(1)));
        message(6) = uint8(hex2dec(s(2:3)));
    %case (4)
    %    message(5) = uint8(s(1:2));
    %    message(6) = uint8(hex2dec(s(3:4)));
    otherwise
        disp('Error: something went wrong!');
  end

  % current limit
  current_limit = max(0, min(4095, current_limit));
  c = dec2hex(current_limit);
  switch size(s,2)
    case (1)
        message(7) = uint8(0);
        message(8) = uint8(hex2dec(c));
    case (2)
        message(7) = uint8(0);
        message(8) = uint8(hex2dec(c));
    case (3)
        message(7) = uint8(hex2dec(c(1)));
        message(8) = uint8(hex2dec(c(2:3)));
    %case (4)
    %    message(7) = uint8(s(1:2));
    %    message(8) = uint8(hex2dec(c(3:4)));
    otherwise
        disp('Error: something went wrong!');
  end
 
  message = uint8(message);
end