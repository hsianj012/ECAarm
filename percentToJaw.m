function [ jaw_pos ] = percentToJaw(percent_open)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    k = 66;
    jaw_pos = k*percent_open;

end

