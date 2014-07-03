function []=plotArm3D(POI,slew)
%plotArm creates plot of the the entire arm in it's current position

r = [];
z = [];

% retrieve r,z coordinates of each arm segment from POI
for i=1:6
   % for each segment, calculate x,y,z
   r = [r,POI(i).r];
   plotr(i) = sum(r(1:i));
   x(i) = plotr(i)*sind(slew);
   y(i) = plotr(i)*cosd(slew);
   z = [z,POI(i).z];
   plotz(i) = sum(z(1:i));
end

hold on
% initiate 3d figure
view(3)

% plot arm segments with a red square on the terminating end (jaw)
plot3(x,y,plotz,'bo-')
plot3(x(6),y(6),plotz(6),'rs-','MarkerFaceColor', [1 0 0])

axis equal
