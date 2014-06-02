function [ angle ] = elbowToAngle( elbow_position )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    k = 569.88;
   
    angle = elbow_position/k;
   
%     if ( elbow_position > 39700 )
%         angle = -165 + (elbow_position-39700)/k;
%     else
%         angle = -120 + elbow_position/k;
%     end
end