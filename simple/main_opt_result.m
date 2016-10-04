idx = 1;
d2d_rt = 10:20:230;

avg_opt_ff = zeros(4,12);
avg_outage = zeros(4, 12);
for idx = 9:12
    load(['exp_' int2str(idx) '.mat']);
    %load(['d2d-opt-rrm' int2str(idx) '.mat']);
    ff = abs(ff);
    idx_nan = isnan(ff);
    ff(idx_nan) = 0;
    ff(ff == 1) = 0;
%     if rem(idx,4) == 0
%         ff(ff > 300) = 0;
%     end
    avg_opt_ff(idx-8,:) = sum(ff,2) / 1000;
    avg_outage(idx-8,:) = outage * 100;
end
% ff
figure;
hold on;
plot(d2d_rt, avg_opt_ff(1,:), 'Color',[1 0 0.5],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, avg_opt_ff(2,:), 'Color',[0 0.48 0.65], 'LineStyle','-', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, avg_opt_ff(3,:), 'Color', [0.03 0.47 0.19],'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',8);
plot(d2d_rt, avg_opt_ff(4,:), 'Color', [0.2 0 0],'LineStyle','-','LineWidth',2,'Marker','^','MarkerSize',8);
grid on;
ylabel('Spectrum efficiency (bps/Hz)');
xlabel('Distance to BS (m)');
legend('R_d = 10','R_d = 30','R_d = 50','R_d = 100');

% outage
figure;
hold on;
plot(d2d_rt, avg_outage(1,:), 'Color',[1 0 0.5],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, avg_outage(2,:), 'Color',[0 0.48 0.65], 'LineStyle','-', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, avg_outage(3,:), 'Color', [0.03 0.47 0.19],'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',8);
plot(d2d_rt, avg_outage(4,:), 'Color', [0.2 0 0],'LineStyle','-','LineWidth',2,'Marker','^','MarkerSize',8);
grid on;
ylabel('Outage probability');
xlabel('Distance to BS (m)');
legend('R_d = 10','R_d = 30','R_d = 50','R_d = 100');