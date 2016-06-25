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

qos = 1;

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
        
        % generate cellular channel response at BS
        [cue_pathloss, cue_shadowing, cue_fading] = gen_cellular_channel(users_pos, FREQ, pathloss_parameters(idx));
        cue_channel_response = (abs(cue_fading).^2).*10.^((cue_shadowing-cue_pathloss)./10);
        
        % generate d2d to cellular channel response
        [d2d_cue_pathloss, d2d_cue_shadowing, d2d_cue_fading] = gen_cellular_channel(d2d_tr, FREQ, pathloss_parameters(idx));
        d2d_cue_channel_response = (abs(d2d_cue_fading).^2).*10.^((d2d_cue_shadowing-d2d_cue_pathloss)./10);
        
        % calculate d2d and cellular transmit power
        [d2d_tp, cue_tp] = cal_tp_d2d_optimal(d2d_cue_channel_response, cue_channel_response, qos, PTOTAL, N_SEC*N_USER);
        
        interference_array = cal_interference_single_orig(N_USER*N_SEC);
        % cellular and d2d SINR
        cue_SINR_array = cal_SINR_orig(cue_tp.*cue_channel_response, [d2d_tp.*d2d_cue_channel_response;zeros(1,N_SC*N_SEC*N_USER)]);
        d2d_rp_array = cal_power_d2d_pair(d2d_tr, d2d_rc, d2d_tp, FREQ, pathloss_parameters(idx));
        [~, d2d_interference_array] = cal_interference_d2d_backoff(interference_array, interference_array, d2d_tr, d2d_rc, d2d_tp, users_pos, cue_tp, N_SEC*N_USER, pathloss_parameters(idx));
        d2d_SINR_array = cal_SINR_orig(d2d_rp_array, [d2d_interference_array;zeros(1,N_USER*N_SC*N_SEC)]);
        
        % throughput
        cellular_throughput = cal_throughput_fair_rr(cue_SINR_array, N_USER*N_SEC);
        d2d_throughput = cal_throughput_fair_rr(d2d_SINR_array, N_USER*N_SEC);
        
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

save('optimal1_final.mat','overall_d2d_throughput', 'overall_orig_throughput', 'group', 'LOOP');
%% plot CDF of average rb spectral efficiency
% cdfplot(uplink_rb_spec_eff);