close all

slew = 30

[X,Y,Z,POI1]=angleToPoint(0,0,0);
subplot(2,2,1)
plotArm2D(POI1)
% figure(2)
% plotArm3D(POI1,slew)
% title('shoulder: 0, elbow: 0')

[X2,Y2,Z2,POI2]=angleToPoint(90,90,0);
subplot(2,2,2)
plotArm2D(POI2)
% title('shoulder: 30, elbow: 30')

[X3,Y3,Z3,POI3]=angleToPoint(0,90,90);
subplot(2,2,3)
plotArm2D(POI3)
% title('shoulder: 30, elbow: 60')

[X4,Y4,Z4,POI4]=angleToPoint(0,0,90);
subplot(2,2,4)
plotArm2D(POI4)
% title('shoulder: 30, elbow: 90')


