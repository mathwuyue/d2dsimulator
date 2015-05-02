function [interference] = cal_interference_orig(centers, isd, n_user, ptotal, freq, alpha)
% global constants
N_SC = 600;


% constants
TOTAL_BS_POWER = ptotal;
N_USER = n_user;

%% generate interference users
inter_users = gen_users(centers(centers~=0), N_USER,  isd);

%% calculate distances between users and basestations.
dist_users = abs(inter_users);

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
tmp = logical(ones(size(inter_users)));
h = cal_fading_orig(20,12,0.8,0.8, N_USER,tmp, ~tmp, length(centers(centers~=0)));

% final power array
interference = (abs(h)).^2.*sub_power_array;
end