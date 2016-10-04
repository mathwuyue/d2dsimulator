% main_d2d_powers
% global N_SC N_SEC N_RB;
N_SC = 600;
N_RB = 50;

%% constant
PTOTAL = -10;        % dB W
PCIRCUIT = 0.05;     % W
FREQ = 2.15;         % GHz
ISD = 250;
LAMBDA = 20/(pi*1500^2);
N_USER = 5;
LOOP = 10000;
pathloss_parameter = 3.5;

n_rb_user = N_RB / N_USER;
% D2D radius (m)
d2d_r = 20;

% avg throughput
d2d_avg_throughput = 0;

%% Monte Carlo simulation
for i = 1:LOOP
    cc_ues = gen_user_ul([0,0], N_USER, ISD);
    [d2d_tr, d2d_rc] = gen_d2d_pair(ISD, d2d_r, 1);
    % cc ue tps
    cc_tps = cal_cc_tps(abs(cc_ues),10^(PTOTAL/10),0,pathloss_parameter);
    % d2d received channel gain
    d2d_gain = cal_channel_gain(d2d_tr, d2d_rc, N_RB, FREQ, pathloss_parameter);
    % d2d received power
    d2d_rp = 10^(PTOTAL/10)*d2d_gain;
    % interferenced channel gain
    cc_interference_gain = cal_channel_gain(cc_ues, d2d_rc, n_rb_user, FREQ, pathloss_parameter);
    % interference power
    cc_interference_p = kron(cc_tps,ones(1,n_rb_user)) .* cc_interference_gain;
    % SINR
    d2d_sinr = cal_SINR_orig(d2d_rp, cc_interference_p);
    % throughput of d2d
    d2d_throughput = sum(log2(1+d2d_sinr));
    % Monte Carlo sum up
    d2d_avg_throughput = d2d_avg_throughput + d2d_throughput;
end

d2d_avg_throughput = d2d_avg_throughput / LOOP