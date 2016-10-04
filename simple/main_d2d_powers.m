% main_d2d_powers
% global N_SC N_SEC N_RB;
N_SC = 600;
N_RB = 50;

%% constant
PTOTAL = -10;
PCIRCUIT = 0.05;
FREQ = 2.15;
ISD = 250;
LAMBDA = 20/(pi*1500^2);
N_USER = 5;
LOOP = 25000;
pathloss_parameter = 3.5;

n_rb_user = N_RB / N_USER;
d2d_threshold = 10^(-8/10);
cc_threshold = 10^(8.75/10);
rho_cc = 0.9;
rho_d = 0.9;
rho_cd = 0.8;
K = 11;
d2d_rt = 10:10:250;
d_c = 10:10:250;

%% plot p_c, p_max^d
% plot p_c
p_c1 = cal_cc_tps(d_c, 10^(PTOTAL/10), 0, pathloss_parameter);
p_c2 = cal_cc_tps(d_c, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_c3 = cal_cc_tps(d_c, 10^(PTOTAL/10)*ISD^(-1*pathloss_parameter), 1, pathloss_parameter);
figure;
hold on;
plot(d_c, 10*log10(p_c1)+30, 'Color',[0.03 0.47 0.19],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d_c, 10*log10(p_c2)+30, 'Color',[0 0.48 0.65], 'LineStyle','-', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d_c, 10*log10(p_c3)+30, 'Color', [1 0 0.5],'LineStyle','-','LineWidth',2,'Marker','s','MarkerSize',8);
legend('\epsilon = 0', '\epsilon = 0.5', '\epsilon = 1', 'Location', 'SouthEast');
grid on;
xlim([10 250]);
xlabel('Distance to the BS (m)');
ylabel('Transmit power (dBm)');

% plot p_max^d
% plot p_max^d versus CC position in terms of different epsilon
epsilon = 0:0.05:1;
d_d2d_resuse1 = cal_d2d_resuse_d_c(ISD.^(-epsilon*2.5),1,LAMBDA,rho_cd,d2d_threshold,epsilon,2.5);
d_d2d_resuse2 = cal_d2d_resuse_d_c(ISD.^(-epsilon*3),1,LAMBDA,rho_cd,d2d_threshold,epsilon,3);
d_d2d_resuse3 = cal_d2d_resuse_d_c(ISD.^(-epsilon*3.5),1,LAMBDA,rho_cd,d2d_threshold,epsilon,3.5);
d_d2d_resuse4 = cal_d2d_resuse_d_c(ISD.^(-epsilon*4),1,LAMBDA,rho_cd,d2d_threshold,epsilon,4);
figure;
hold on;
plot(epsilon, d_d2d_resuse1, 'Color',[0.03 0.47 0.19],'LineStyle', '-', 'LineWidth', 2, 'Marker','+','MarkerSize',8);
plot(epsilon, d_d2d_resuse2, 'Color',[0 0.48 0.65], 'LineStyle','-', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(epsilon, d_d2d_resuse3, 'Color', [1 0 0.5],'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',8);
plot(epsilon, d_d2d_resuse4, 'Color', [0.2 0 0],'LineStyle','-','LineWidth',2,'Marker','^','MarkerSize',8);
legend('\alpha = 2.5', '\alpha = 3', '\alpha = 3.5','\alpha = 4');
grid on;
xlabel('\epsilon');
ylabel('Maximum distance from CC UE to the BS (m)');

% p_max_d2d1 = cal_p_max_d2d(10,d2d_rt,10^(PTOTAL/10),10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
% p_max_d2d2 = cal_p_max_d2d(60,d2d_rt,10^(PTOTAL/10),10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
% p_max_d2d3 = cal_p_max_d2d(120,d2d_rt,10^(PTOTAL/10),10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
pathloss_parameter = 2.5;
p_c1 = cal_cc_tps(10, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_c2 = cal_cc_tps(60, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_c3 = cal_cc_tps(120, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_max_d2d1 = cal_p_max_d2d(10,d2d_rt,p_c1,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d2 = cal_p_max_d2d(60,d2d_rt,p_c2,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d3 = cal_p_max_d2d(120,d2d_rt,p_c3,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
pathloss_parameter = 3.5;
p_c1 = cal_cc_tps(10, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_c2 = cal_cc_tps(60, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_c3 = cal_cc_tps(120, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_max_d2d4 = cal_p_max_d2d(10,d2d_rt,p_c1,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d5 = cal_p_max_d2d(60,d2d_rt,p_c2,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d6 = cal_p_max_d2d(120,d2d_rt,p_c3,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
% p_c1 = cal_cc_tps(20, 10^(PTOTAL/10)*ISD^(-1*pathloss_parameter), 1, pathloss_parameter);
% p_c2 = cal_cc_tps(150, 10^(PTOTAL/10)*ISD^(-1*pathloss_parameter), 1, pathloss_parameter);
% p_c3 = cal_cc_tps(250, 10^(PTOTAL/10)*ISD^(-1*pathloss_parameter), 1, pathloss_parameter);
% p_max_d2d7 = cal_p_max_d2d(20,d2d_rt,p_c1,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA/(pi*1500^2),pathloss_parameter);
% p_max_d2d8 = cal_p_max_d2d(150,d2d_rt,p_c2,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA/(pi*1500^2),pathloss_parameter);
% p_max_d2d9 = cal_p_max_d2d(250,d2d_rt,p_c3,10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA/(pi*1500^2),pathloss_parameter);
figure;
hold on;
plot(d2d_rt, 10*log10(p_max_d2d1)+30, 'Color',[0.03 0.47 0.19],'LineStyle', '-', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, 10*log10(p_max_d2d2)+30, 'Color',[0 0.48 0.65], 'LineStyle','-', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, 10*log10(p_max_d2d3)+30, 'Color', [1 0 0.5],'LineStyle','-','LineWidth',2,'Marker','s','MarkerSize',8);
plot(d2d_rt, 10*log10(p_max_d2d4)+30, 'Color',[0.03 0.47 0.19],'LineStyle', '--', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
plot(d2d_rt, 10*log10(p_max_d2d5)+30, 'Color',[0 0.48 0.65], 'LineStyle','--', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
plot(d2d_rt, 10*log10(p_max_d2d6)+30, 'Color', [1 0 0.5],'LineStyle','--','LineWidth',2,'Marker','s','MarkerSize',8);
% plot(d2d_rt, 10*log10(p_max_d2d7)+30, 'Color',[0.03 0.47 0.19],'LineStyle', '-.', 'LineWidth', 2, 'Marker','x','MarkerSize',8);
% plot(d2d_rt, 10*log10(p_max_d2d8)+30, 'Color',[0 0.48 0.65], 'LineStyle','-.', 'LineWidth', 2, 'Marker','o', 'MarkerSize',8);
% plot(d2d_rt, 10*log10(p_max_d2d9)+30, 'Color', [1 0 0.5],'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',8);
legend('CC dist.=20,\epsilon=0','CC dist.=80,\epsilon=0','CC dist.=150,\epsilon=0','CC dist.=20,\epsilon=0.5','CC dist.=80,\epsilon=0.5','CC dist.=150,\epsilon=0.5');
grid on;
xlabel('Distance between D2D transmitter to BS (m)');
ylabel('Maximum allowed transmit power (dBm)');
xlim([10 250]);

%% d2d region
% proposition
% d2d transmitter Location
d2d_rt = [10 50 100 150 200 250];
% thetas
theta_d = 0;
theta_r = linspace(0, 2*pi, 73);
theta_r = theta_r(1:72);
theta_c = pi/2;
% reshape matrixs
d2d_rt = repmat(d2d_rt', 1, 72);
theta_r = repmat(theta_r, 6, 1);
% p_c
p_c1 = 10^(PTOTAL/10);
p_c2 = cal_cc_tps(10, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_c3 = cal_cc_tps(60, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
p_c4 = cal_cc_tps(120, 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
% p_d2d
p_max_d2d1 = cal_p_max_d2d(10, d2d_rt, p_c1, 10^(PTOTAL/10), d2d_threshold, rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d2 = cal_p_max_d2d(60, d2d_rt, p_c1, 10^(PTOTAL/10), d2d_threshold, rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d3 = cal_p_max_d2d(120, d2d_rt, p_c1, 10^(PTOTAL/10), d2d_threshold, rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d4 = cal_p_max_d2d(10, d2d_rt, p_c2, 10^(PTOTAL/10), d2d_threshold, rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d5 = cal_p_max_d2d(60, d2d_rt, p_c3, 10^(PTOTAL/10), d2d_threshold, rho_cd,LAMBDA,pathloss_parameter);
p_max_d2d6 = cal_p_max_d2d(120, d2d_rt, p_c4, 10^(PTOTAL/10), d2d_threshold, rho_cd,LAMBDA,pathloss_parameter);

% d2d radius
d2d_d1 = cal_d2d_radius(p_max_d2d1, p_c1, 10^(PTOTAL/10), d2d_rt, 10, theta_d, theta_c(1),theta_r,d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
d2d_d2 = cal_d2d_radius(p_max_d2d2, p_c1, 10^(PTOTAL/10), d2d_rt, 10, theta_d, theta_c(1),theta_r,d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
d2d_d3 = cal_d2d_radius(p_max_d2d3, p_c1, 10^(PTOTAL/10), d2d_rt, 10, theta_d, theta_c(1),theta_r,d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
d2d_d4 = cal_d2d_radius(p_max_d2d4, p_c2, 10^(PTOTAL/10), d2d_rt, 10, theta_d, theta_c(1),theta_r,d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
d2d_d5 = cal_d2d_radius(p_max_d2d5, p_c3, 10^(PTOTAL/10), d2d_rt, 10, theta_d, theta_c(1),theta_r,d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
d2d_d6 = cal_d2d_radius(p_max_d2d6, p_c4, 10^(PTOTAL/10), d2d_rt, 10, theta_d, theta_c(1),theta_r,d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);

