function d2d_rp = cal_power_d2d_pair(d2d_tr, d2d_rc, d2d_tp, freq, alpha)
% global constants
N_SC=600;

% constants
TOTAL_BS_POWER = d2d_tp;
FREQ = freq;

%% calculate distances between users and basestations.
dist_users = abs(d2d_tr-d2d_rc);

path_loss = 10*alpha*log10(dist_users) + 22.7 + 26*log10(FREQ);
shadowing = 4*ones(size(dist_users));

path_loss = kron(path_loss, ones(1,N_SC));
shadowing = kron(shadowing, ones(1,N_SC));

% caculate transmit power
t_p = TOTAL_BS_POWER - path_loss;

%% caculate interference power
% caculate shadowing
sub_power_array = 10.^((t_p+shadowing.*randn(size(shadowing)))./10);
% caculate h
tmp = logical(ones(1, length(dist_users)));
h = cal_fading_orig(20,12,0.8,0.8,length(d2d_tr),~tmp, tmp, 1);
% final power array
d2d_rp = (abs(h)).^2.*sub_power_array;
end