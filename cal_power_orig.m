function [power_array] = cal_power_orig(users_pos, ptotal, freq, alpha)
% global constants
N_SC=600;

% constants
TOTAL_BS_POWER = ptotal;


%% calculate distances between users and basestations.
dist_users = abs(users_pos);

%%  calculate pathloss and shadowing
pathloss = alpha*10*log10(dist_users) + 22.7 + 26*log10(freq);
shadowing = 4*ones(size(dist_users));

pathloss = kron(pathloss, ones(1,N_SC));
shadowing = kron(shadowing, ones(1,N_SC));
shadowing = shadowing.*randn(size(shadowing));

% caculate transmit power
t_p = TOTAL_BS_POWER - pathloss;

%% caculate interference power
% caculate shadowing
sub_power_array = 10.^((t_p+shadowing)./10);
% caculate h
tmp = logical(ones(1, length(users_pos)));

h = cal_fading_orig(20,12,0.8,0.8,length(users_pos),~tmp, tmp, 1);
% final power array
power_array = (abs(h)).^2.*sub_power_array;
end