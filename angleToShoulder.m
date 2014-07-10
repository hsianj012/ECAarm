function [ shoulder ] = angleToShoulder( angle )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%     k = 798;
    k = 728.177;
   
    shoulder = 2^16 - k*angle;

end