function [ shoulder ] = angleToShoulder( angle )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    k = 798;
   
    shoulder = 2^16 - k*angle;

end