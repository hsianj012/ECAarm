function [ startPosition ] = getInitPosition()
%getInitPosition Gets starting position from arm
%   Sends a 'blank' or stop command to arm, then interprets returned
%   packets for starting position

stopCommand = getMotorDemandCommand([0 0 0 0 0],[0 0 0 0 0 0],4095*zeros(5,1),4095*zeros(5,1));
startPosition = zeros(5, 1);
offset_position = 6;
width = 9;

% communication settings
s = serial('COM2'); % '\dev\tty.usb'
set(s,'BaudRate',115200);
set(s,'ByteOrder','bigEndian');
get(s);

% start connection
fopen(s);

% send stop message
fwrite(s,stopCommand);

pause(0.05)

if 0<s.BytesAvailable
    data = fread(s,s.BytesAvailable);
    for j=1:5
    position(j) = data(offset_position + (j-1)*width) + ...
        256*data(offset_position + (j-1)*width + 1);
    end
end
startPosition(1) = shoulderToAngle(position(1));
startPosition(2) = slewToAngle(position(2));
startPosition(3) = elbowToAngle(position(3));
% startPosition(4) = wristToAngle(position(4));
startPosition(5) = jawToPercent(position(5));

fclose(s);


