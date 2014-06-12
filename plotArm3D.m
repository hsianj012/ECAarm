function []=plotArm3D(POI,slew);
%plotArm creates plot of the the entire arm in it's current position

r = [];
z = [];

for i=1:6
   r = [r,POI(i).r];
   plotr(i) = sum(r(1:i));
   x(i) = plotr(i)*sind(slew);
   y(i) = plotr(i)*cosd(slew);
   z = [z,POI(i).z];
   plotz(i) = sum(z(1:i));
end
hold on
view(3)
plot3(x,y,plotz,'bo-')
plot3(x(6),y(6),plotz(6),'rs-','MarkerFaceColor', [1 0 0])

axis equal
