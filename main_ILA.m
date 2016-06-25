% global N_SC N_SEC N_RB;
N_SC = 600;
N_SEC = 3;
N_RB = 50;

%% constant                                               % each scenario loops 1000 times
PTOTAL = -7;
FREQ = 2.15;
ISD = 500;
N_USER = 10;
N_TIER = 1;
LOOP = 2500;

d2d_throughput_tmp = zeros(1,7);
cellular_throughput_tmp = zeros(1,7);

d2d_range = 20;
d2d_radius = 0;

pathloss_parameters = [1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5];

tic

%% parallel doing loop
spmd
for i=1:LOOP
    % generate user drop
    for idx = 1:7
        users_pos = gen_user([0,0], N_USER, ISD);
        
        % generate d2d pair drop
        [d2d_tr, d2d_rc] = gen_d2d_pairs([0,0], d2d_range, N_USER, d2d_radius, ISD);
        
        % generate single cell interference                        d2d_tr, d2d_rc, d2d_tp, cue_pos, cue_tp, n, isd, s, isLOS, freq)
        [d2d_throughput, cellular_throughput] = cal_throughput_ILA(d2d_tr, d2d_rc, PTOTAL, users_pos, PTOTAL, N_USER*N_SEC, ISD, FREQ, pathloss_parameters(idx));                     

        d2d_throughput_tmp(idx) = d2d_throughput_tmp(idx) + d2d_throughput;
        cellular_throughput_tmp(idx) = cellular_throughput_tmp(idx) + cellular_throughput;
    end
end
end


%% gather results
uplink_user_throughput = zeros(1,7);
d2d_throughput = zeros(1,7);

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

save('ila.mat','overall_d2d_throughput', 'overall_orig_throughput', 'group', 'LOOP');
%% plot CDF of average rb spectral efficiency
% cdfplot(uplink_rb_spec_eff);