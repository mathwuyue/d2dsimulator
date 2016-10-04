load('d2d_range_result.mat')

figure;

subplot(1,3,1);
hold on;
r=250;
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(xp,yp);
plot(100*cos(0),100*sin(0),'Marker','o','Color', [0 0.48 0.65]);
plot(10*cos(pi/2),10*sin(pi/2),'Marker','s','Color',[0.03 0.47 0.19]);
plot(0, 0, 'Marker', '^', 'Color', 'red');
dr = d2d_d(4,2*72+1:3*72);
theta = linspace(0,2*pi,73);
theta = theta(1:72);
x = 100*cos(0) + dr .* cos(theta);
y = 100*sin(0) + dr .* sin(theta);
scatter(x,y,'Marker','x','MarkerEdgeColor',[1 0 0.5]);
plot(x,y);

subplot(1,3,2);
hold on;
r=250;
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(xp,yp);
plot(100*cos(0),100*sin(0),'Marker','o','Color', [0 0.48 0.65]);
plot(60*cos(pi/2),60*sin(pi/2),'Marker','s','Color',[0.03 0.47 0.19]);
plot(0, 0, 'Marker', '^', 'Color', 'red');
dr = d2d_d(5,2*72+1:3*72);
theta = linspace(0,2*pi,73);
theta = theta(1:72);
x = 100*cos(0) + dr .* cos(theta);
y = 100*sin(0) + dr .* sin(theta);
scatter(x,y,'Marker','x','MarkerEdgeColor',[1 0 0.5]);
plot(x,y);

subplot(1,3,3);
hold on;
r=250;
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(xp,yp);
plot(100*cos(0),100*sin(0),'Marker','o','Color', [0 0.48 0.65]);
plot(120*cos(pi/2),120*sin(pi/2),'Marker','s','Color',[0.03 0.47 0.19]);
plot(0, 0, 'Marker', '^', 'Color', 'red');
dr = d2d_d(6,2*72+1:3*72);
theta = linspace(0,2*pi,73);
theta = theta(1:72);
x = 100*cos(0) + dr .* cos(theta);
y = 100*sin(0) + dr .* sin(theta);
scatter(x,y,'Marker','x','MarkerEdgeColor',[1 0 0.5]);
plot(x,y);