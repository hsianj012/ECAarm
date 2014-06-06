emptySet = zeros(1,10);
zero2nine = linspace(0,90,10);
alpha = [emptySet,emptySet,zero2nine]; % slew 
gamma = [emptySet,zero2nine,90*ones(1,10)]; % shoulder
beta = [zero2nine,90*ones(1,20)]; % elbow

l = length(alpha);

x = zeros(1,l);
y = zeros(1,l);
z = zeros(1,l);

for i=1:l
    [x(i),y(i),z(i)] = angleToPoint(alpha(i),gamma(i),beta(i));
end

plot3(x,y,z)