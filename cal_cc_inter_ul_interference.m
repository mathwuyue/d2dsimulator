function [inter_interference, cc_ue] = cal_cc_inter_ul_interference(centers, n_d2d, ptotal, isd, freq, alpha)
% constants
N_SC = 600;

% gen cc_ue
cc_ue = gen_ul_interference_users(centers(centers~=0), n_d2d, isd);

% calculate inter distance
inter_dist = abs(cc_ue);


%% calculate received power
% calcluate path_loss
path_loss = 10*alpha*log10(inter_dist) + 22.7 + 26*log10(freq);
% calculate shadowing
shadowing = 4*ones(size(inter_dist));
shadowing = shadowing.*randn(size(shadowing));

% caculate received power (no h)
t_p = ptotal - path_loss + shadowing;
sub_power_array = 10.^(t_p./10);
sub_power_array = kron(sub_power_array, ones(1, N_SC/n_d2d));

% caculate h
h = sqrt(0.5)*randn(length(centers)-1, N_SC)+sqrt(0.5)*randn(length(centers)-1, N_SC)*1j;

% final power array
inter_interference = (abs(h)).^2.*sub_power_array;
inter_interference = sum(inter_interference);
end