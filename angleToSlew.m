function [ slew ] = angleToSlew( angle )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    k = 588.14;
   
    slew = k * angle;
   
%     if ( angle > 80.6 )
%         slew = (angle-80.6)*k;
%     else
%         slew = (angle-8.6)*k + 23200;
%     end

end