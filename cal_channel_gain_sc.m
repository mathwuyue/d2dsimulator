function channel_gain = cal_channel_gain_sc(p1, p2, n, n_sc, freq, alpha)
% n_sc_p
n_sc_p = n_sc / n;

cc_bs_dist = abs(p1 - p2);
path_loss = 10*alpha*log10(cc_bs_dist) + 22.7 + 26*log10(freq);
% calculate shadowing
shadowing = 4*ones(size(cc_bs_dist));
shadowing = shadowing.*randn(size(shadowing));
% caculate received power (no h)
channel_gain = -path_loss + shadowing;
channel_gain = 10.^(channel_gain./10);
channel_gain = kron(channel_gain, ones(1, n_sc_p));
% fading
h = sqrt(0.5)*randn(1, n_sc)+sqrt(0.5)*randn(1, n_sc)*1j;
% final power array
channel_gain = (abs(h)).^2.*channel_gain;
end