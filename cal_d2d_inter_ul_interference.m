function inter_interference = cal_d2d_inter_ul_interference(centers, d2d_rc, cc_inter_ul_ue, n_cc_ul_ue, ptotal, freq, alpha)
% constants
N_SC = 600;
n_sc_ue = N_SC / n_cc_ul_ue;

% calculate inter distance
inter_dist = abs(d2d_rc - cc_inter_ul_ue);


%% calculate received power
% calcluate path_loss
path_loss = 10*alpha*log10(inter_dist) + 22.7 + 26*log10(freq);

% calculate shadowing
shadowing = 4*ones(size(inter_dist));
shadowing = shadowing.*randn(size(shadowing));

% caculate received power (no h)
t_p = ptotal - path_loss + shadowing;
sub_power_array = 10.^(t_p./10);
sub_power_array = kron(sub_power_array, ones(1, n_sc_ue));

% caculate h
h = sqrt(0.5)*randn(length(centers)-1, N_SC)+sqrt(0.5)*randn(length(centers)-1, N_SC)*1j;

% final power array
inter_interference = (abs(h)).^2.*sub_power_array;
inter_interference = reshape(inter_interference, n_sc_ue*n_cc_ul_ue, length(centers)-1)';
inter_interference = sum([inter_interference;zeros(1,N_SC)]);
end