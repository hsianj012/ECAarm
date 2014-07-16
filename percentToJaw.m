
function [ jaw_pos ] = percentToJaw(percent_open)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    k = 66; % range is smaller for jaw
    jaw_pos = k*percent_open;

end

