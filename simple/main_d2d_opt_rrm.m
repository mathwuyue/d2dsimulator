% d2d eff energy
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
d2d_threshold = 10^(-6/10);
cc_threshold = 10^(8.75/10);
rho_cc = 0.9;
rho_d = 0.9;
rho_cd = 0.8;
K = 11;
d2d_rt = 10:20:230;

%% results
n_cc_ue = 5;
inter_interference = zeros(12, 1000);
cc_interference = zeros(12, 1000*n_cc_ue);
g_d = zeros(12, 1000*n_cc_ue);
p_max_d2ds = zeros(12, 1000*n_cc_ue);

for i=1:12
    for j=1:1000
        % generate uplink ues
        n_inter_cc_ues = poissrnd(LAMBDA*pi*1500^2);
        cc_inter_ues = gen_user_ul([0,0], n_inter_cc_ues, ISD*2*3);
        cc_ue = gen_user_ul([0,0], n_cc_ue, 120);
        %p_c = cal_cc_tps(abs(cc_ue), 10^(PTOTAL/10)*ISD^(-0.5*pathloss_parameter), 0.5, pathloss_parameter);
        p_c = 0.1 * ones(1,n_cc_ue);
        [d2d_tr, d2d_rc] = gen_d2d_pair(d2d_rt(i), 50);
        inter_interference(i,j) = sum(cal_recv_p(cc_inter_ues, d2d_rc, PTOTAL, FREQ, pathloss_parameter));
        cc_interference(i,(j-1)*n_cc_ue+1:j*n_cc_ue) = cal_recv_p(cc_ue, d2d_rc, 10*log10(p_c), FREQ, pathloss_parameter);
        g_d(i,(j-1)*n_cc_ue+1:j*n_cc_ue) = cal_channel_gain(d2d_tr, d2d_rc, n_cc_ue, FREQ, pathloss_parameter);
        for k = 1:n_cc_ue
            p_max_d2ds(i,(j-1)*n_cc_ue+k) = cal_p_max_d2d(abs(cc_ue(k)),d2d_rt(i),p_c(k),10^(PTOTAL/10),d2d_threshold,rho_cd,LAMBDA,pathloss_parameter);
        end
    end
end
p_min_d2ds = cal_d2d_min_tp(g_d, cc_interference, inter_interference, d2d_threshold, n_cc_ue);

save('d2d-opt-rrm-cc5-3.mat','inter_interference','cc_interference','g_d','n_cc_ue','p_max_d2ds','p_min_d2ds');