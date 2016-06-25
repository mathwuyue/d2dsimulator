% global N_SC N_SEC N_RB;
N_SC = 600;
N_SEC = 3;
N_RB = 50;

%% constant                                               % each scenario loops 1000 times
PTOTAL = -7;
FREQ = 2.15;
SCENARIO = 2;
IS_LOS =1;
ISD = 500;
N_USERS = [1, 3, 6, 10, 15, 30];
N_TIER = 1;
LOOP = 2500;

d2d_throughput_tmp = zeros(1,6);
cellular_throughput_tmp = zeros(1,6);

d2d_range = 20;
d2d_area = [10, 30, 50, 80, 120, 150];
d2d_radius = 0;
tic

%% parallel doing loop
spmd
for i=1:LOOP
    % generate user drop
    idx = 1;
    for N_USER=N_USERS
        users_pos = gen_user([0,0], N_USER, ISD);
        
        % generate d2d pair drop
        [d2d_tr, d2d_rc] = gen_d2d_pairs([0,0], d2d_range, N_USER, d2d_radius, ISD);
        
        % generate single cell interference
        zero_i = cal_interference_single_orig(N_USER*N_SEC);
        
        % throughput
        [d2d_throughput, cellular_throughput] = cal_throughput_d2d_max_min(zero_i, zero_i, N_USER*N_SEC, d2d_tr, d2d_rc, users_pos, PTOTAL, PTOTAL, FREQ, SCENARIO, IS_LOS);

        d2d_throughput_tmp(idx) = d2d_throughput_tmp(idx) + d2d_throughput;
        cellular_throughput_tmp(idx) = cellular_throughput_tmp(idx) + cellular_throughput;
        idx = idx + 1;
    end
end
end

%% gather results
uplink_user_throughput = zeros(1,6);
d2d_throughput = zeros(1,6);

% groups
group = length(d2d_throughput_tmp);

% get overall result
for j = 1:group
    d2d_throughput = d2d_throughput_tmp{j} + d2d_throughput;
    uplink_user_throughput = cellular_throughput_tmp{j} + uplink_user_throughput;
end

overall_orig_throughput = uplink_user_throughput / group /LOOP;
overall_d2d_throughput = d2d_throughput / group / LOOP;

toc

save('max_min.mat','overall_d2d_throughput', 'overall_orig_throughput', 'group', 'LOOP');
%% plot CDF of average rb spectral efficiency
% cdfplot(uplink_rb_spec_eff);