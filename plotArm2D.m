function []=plotArm2D(POI);
%plotArm creates plot of the the entire arm in it's current position

r = [];
z = [];

for i=1:6
   r = [r,POI(i).r];
   plotr(i) = sum(r(1:i)); 
   z = [z,POI(i).z];
   plotz(i) = sum(z(1:i));
end
hold on
plot(plotr,plotz,'bo-')
plot(plotr(6),plotz(6),'rs-','MarkerFaceColor', [1 0 0])
hold off
axis equal
