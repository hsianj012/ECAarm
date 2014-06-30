clear all
% make each motor sweep from 0 - 90 degrees, one at a time.
emptySet = zeros(1,10);
zero2nine = linspace(0,90,10);
alpha = [zero2nine,90*ones(1,10)]; % shoulder
beta = [130*ones(1,20)]; % elbow
gamma = [emptySet,zero2nine]; % slew 

l = length(gamma);

x = zeros(1,l);
y = zeros(1,l);
z = zeros(1,l);
slew = zeros(1,l);
shoulder =zeros(1,l);
elbow = zeros(1,l);

writerObj = VideoWriter('sweep2.avi');
open(writerObj);

set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');

% 
% % Make animation of arm movement
% for i=1:l
%     [x(i),y(i),z(i),POI] = angleToPoint(alpha(i),gamma(i),beta(i));
%     plotArm3D(POI,alpha(i));
%     axis([0 20 0 20 -15 15])
%     M(i) = getframe;
%     clf
% end
% 
% Make animation of arm movement ver.2
for i=1:l
    [x(i),y(i),z(i),POI] = angleToPoint(gamma(i),alpha(i),beta(i));
    plotArm3D(POI,gamma(i));
    axis([0 30 0 30 -15 15])
    frame = getframe;
    writeVideo(writerObj,frame);
    clf
end

close(writerObj);

