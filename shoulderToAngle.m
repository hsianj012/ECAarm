function [ angle ] = shoulderToAngle( shoulder_position )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%     k = 798;
    k = 728.177;
   
    angle = (2^16 - shoulder_position)/k;
   
%     if ( shoulder_position < 16000 )
%         angle = -15 + (shoulder_position-16000)/k;
%     else
%         angle = -15 + (shoulder_position- 2^16)/k - 16000/k;
%     end

end

