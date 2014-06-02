function [ demand ] = toDemand( value )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    demand = value + 2^15-1;
    if demand > 2^16
        demand = demand - 2^16;
    elseif demand < 0
        disp('Something went wrong');
    end

end