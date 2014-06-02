function [ elbow ] = angleToElbow( angle )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    k = 569.88;
   
    elbow = k*angle;
   
%     if ( angle > -120 )
%         elbow = (angle + 120)*k;
%     else
%         elbow = (angle + 165)*k + 39700;
%     end
end