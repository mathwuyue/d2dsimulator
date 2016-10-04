%%data
db_eff = 10*log10(effmat);
d2d_rt = linspace(10, 230, 12);

% 10(m)
figure;
hold on;

l1 = db_eff(1,:);
l2 = db_eff(2,:);
l3 = 10*log10(throughput2(1:12, 5) / 40);

plot(d2d_rt, l1, 'Color',[1 0 0.5],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, l2, 'Color',[0 0.48 0.65], 'LineStyle','--', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, l3, 'Color', [0.03 0.47 0.19],'LineStyle',':','LineWidth',2,'Marker','^','MarkerSize',8);

legend('0W', '0.25W', '40W');

xlabel('D2D location (m)');
ylabel('Energy efficiency (dB)');
title('D2D transmission radius as 10m');

grid on;
grid minor;

ylim([-20 40]);

% 30(m)
figure;
hold on;

idx2 = (1:12) + 12;
l1 = db_eff(4,:);
l2 = db_eff(5,:);
l3 = 10*log10(throughput2(idx2, 5) / 40);

plot(d2d_rt, l1, 'Color',[1 0 0.5],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, l2, 'Color',[0 0.48 0.65], 'LineStyle','--', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, l3, 'Color', [0.03 0.47 0.19],'LineStyle',':','LineWidth',2,'Marker','^','MarkerSize',8);

legend('0W', '0.25W', '40W');

xlabel('D2D location (m)');
ylabel('Energy efficiency (dB)');
title('D2D transmission radius as 30m');

grid on;
grid minor;
ylim([-20 40]);

% 50(m)
figure;
hold on;

l1 = db_eff(7,:);
l2 = db_eff(8,:);
idx2 = (1:12) + 24;
l3 = 10*log10(throughput2(idx2, 5) / 40);

plot(d2d_rt, l1, 'Color',[1 0 0.5],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, l2, 'Color',[0 0.48 0.65], 'LineStyle','--', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, l3, 'Color', [0.03 0.47 0.19],'LineStyle',':','LineWidth',2,'Marker','^','MarkerSize',8);

legend('0W', '0.25W', '40W');

xlabel('D2D location (m)');
ylabel('Energy efficiency (dB)');
title('D2D transmission radius as 50m');

grid on;
grid minor;
ylim([-20 40]);

% 100(m)
figure;
hold on;

l1 = db_eff(10,:);
l2 = db_eff(11,:);
idx2 = (1:12) + 36;
l3 = 10*log10(throughput2(idx2, 5) / 40);

plot(d2d_rt, l1, 'Color',[1 0 0.5],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, l2, 'Color',[0 0.48 0.65], 'LineStyle','--', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, l3, 'Color', [0.03 0.47 0.19],'LineStyle',':','LineWidth',2,'Marker','^','MarkerSize',8);

legend('0W', '0.25W', '40W');

xlabel('D2D location (m)');
ylabel('Energy efficiency (dB)');
title('D2D transmission radius as 100m');

grid on;
grid minor;
ylim([-20 40]);


