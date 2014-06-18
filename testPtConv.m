clear all
% make each motor sweep from 0 - 90 degrees, one at a time.
emptySet = zeros(1,10);
zero2nine = linspace(0,90,10);
alpha = [emptySet,zero2nine]; % slew 
gamma = [zero2nine,90*ones(1,10)]; % shoulder
beta = [emptySet,emptySet]; % elbow

l = length(alpha);

x = zeros(1,l);
y = zeros(1,l);
z = zeros(1,l);
r = zeros(1,l);
slew = zeros(1,l);
shoulder =zeros(1,l);
elbow = zeros(1,l);

% (x,y,z) for each set of angles
for i=1:l
    [x(i),y(i),z(i)] = angleToPoint(alpha(i),gamma(i),beta(i));
    r(i) = sqrt(x(i)^2+y(i)^2+z(i)^2);
end

% 3D plot of where the jaw has moved.
figure(1)
plot3(x,y,z)
axis equal
grid on
title('jaw movement')
xlabel('x location')
ylabel('y location')
zlabel('z location')


for j=1:l
    [slew(j),shoulder(j),elbow(j)]=pointToAngle(x(j),y(j),z(j));
end

figure(2)
index = 1:l;
target = 90*ones(1,l);
plot(index,slew,'b',index,shoulder,'r',index,elbow,'g', index,target,'m:')
title('Joint Angles')
ylabel('Angle (degrees)')
legend('slew','shoulder','elbow')
