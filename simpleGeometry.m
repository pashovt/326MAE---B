angle = 180 - 68.19 - 68.19;
x1 = 0; 
x2 = x1 + 139;
x3 = x2 + cosd(angle)*88.41;
x4 = x3 + 133;
x5 = x4 + cosd(angle)*88.41;
x6 = x5 + 203;
x = [x1 x2 x3 x4 x5 x6];

y1 = 0;
y2 = 0;
y3 = sind(angle)*88.41;
y4 = y3;
y5 = 0;
y6 = 0;
y = [y1 y2 -y3 -y4 y5 y6];

plot(x,y)

xlim([-100 700])
ylim([-100 100])
