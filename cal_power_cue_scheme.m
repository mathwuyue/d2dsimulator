function [power_array] = cal_power_cue_scheme(users_pos, s, isLOS, ptotal, freq)
% global constants
N_SC=600;

% constants
TOTAL_BS_POWER_ARRAY = kron(ptotal, ones(1,N_SC));
FREQ = freq;

%% calculate distances between users and basestations.
dist_users = abs(users_pos);

switch isLOS
    case 1
        user_prob_los_array = gen_prob_los(dist_users, s);
    case 2
        user_prob_los_array = zeros(size(dist_users));
    case 3
        user_prob_los_array = ones(size(dist_users));
end

% caculate index for prob_los == 0
idx_users = user_prob_los_array == 0;
path_loss = zeros(size(dist_users));
shadowing = zeros(size(dist_users));
switch s
    case 1
        [path_loss(idx_users), shadowing(idx_users)] = UMi_NLOS(dist_users(idx_users), FREQ);
        [path_loss(~idx_users), shadowing(~idx_users)] = UMi_LOS(dist_users(~idx_users), FREQ);
    case 2
        [path_loss(idx_users), shadowing(idx_users)] = UMa_NLOS(dist_users(idx_users), FREQ);
        [path_loss(~idx_users), shadowing(~idx_users)] = UMa_LOS(dist_users(~idx_users), FREQ);
    case 3
        [path_loss(idx_users), shadowing(idx_users)] = SMa_NLOS(dist_users(idx_users), FREQ);
        [path_loss(~idx_users), shadowing(~idx_users)] = SMa_LOS(dist_users(~idx_users), FREQ);
    case 4
        [path_loss(idx_users), shadowing(idx_users)] = RMa_NLOS(dist_users(idx_users), FREQ);
        [path_loss(~idx_users), shadowing(~idx_users)] = RMa_LOS(dist_users(~idx_users), FREQ);
end

path_loss = kron(path_loss, ones(1,N_SC));
shadowing = kron(shadowing, ones(1,N_SC));

% caculate transmit power
t_p = TOTAL_BS_POWER_ARRAY - path_loss;

%% caculate interference power
% caculate shadowing
sub_power_array = 10.^((t_p+shadowing.*randn(size(shadowing)))./10);
% caculate h
tmp = gather(idx_users);
h = cal_fading_orig(20,12,0.8,0.8,length(users_pos),~tmp, tmp, 1);
% final power array
power_array = (abs(h)).^2.*sub_power_array;
end