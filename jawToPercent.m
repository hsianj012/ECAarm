function [ percent_open ] = jawToPercent(jaw_pos)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    k = 66; % range is smaller for jaw
    percent_open = jaw_pos/k;
end

