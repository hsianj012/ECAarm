function [ angle ] = slewToAngle( slew_position )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%     k = 588.14;
    k = 546.133;
   
    angle = slew_position/k;
%    
%     if ( slew_position > 23200 )
%         angle = 8.6 + (slew_position-23200)/k;
%     else
%         angle = 80.6 + slew_position/k;
%     end

end