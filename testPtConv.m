clear all
% make each motor sweep from 0 - 90 degrees, one at a time.
emptySet = zeros(1,10);
zero2nine = linspace(0,90,10);
alpha = [emptySet,emptySet,zero2nine]; % slew 
gamma = [emptySet,zero2nine,90*ones(1,10)]; % shoulder
beta = [zero2nine,90*ones(1,20)]; % elbow

l = length(alpha);

x = zeros(1,l);
y = zeros(1,l);
z = zeros(1,l);
slew = zeros(1,l);
shoulder =zeros(1,l);
elbow = zeros(1,l);

% (x,y,z) for each set of angles
for i=1:l
    [x(i),y(i),z(i)] = angleToPoint(alpha(i),gamma(i),beta(i));
end

% 3D plot of where the jaw has moved.
subplot(1,2,1)
plot3(x,y,z)
axis equal
grid on
title('jaw movement')



for j=1:l
    [slew(j),shoulder(j),elbow(j)]=pointToAngle(x(j),y(j),z(j));
end
subplot(1,2,2)
index = 1:l;
plot(index,slew,'b',index,shoulder,'r',index,elbow,'g', [0 30],[90 90],'m')
title('Joint Angles')
legend('slew','shoulder','elbow')


