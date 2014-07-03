function []=plotArm2D(POI)
%plotArm creates plot of the the entire arm in it's current position

r = [];
z = [];

% retrieve r,z for each arm segment
% then create r,z coordinates
for i=1:6
   r = [r,POI(i).r];
   plotr(i) = sum(r(1:i)); 
   z = [z,POI(i).z];
   plotz(i) = sum(z(1:i));
end

% plot sideview of arm segments
hold on
plot(plotr,plotz,'bo-')
% plot red square on terminating end (jaw)
plot(plotr(6),plotz(6),'rs-','MarkerFaceColor', [1 0 0])
hold off
axis equal
