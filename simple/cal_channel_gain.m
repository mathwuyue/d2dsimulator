function channel_gain = cal_channel_gain(d2d_tr, d2d_rc, n_rb_user, freq, alpha)
%% calculate distances between users and basestations.
dist_users = abs(d2d_tr-d2d_rc);

path_loss = 10*alpha*log10(dist_users) + 22.7 + 26*log10(freq);
shadowing = 4*ones(size(dist_users));
shadowing = shadowing.*randn(size(shadowing));

path_loss = kron(path_loss, ones(1,n_rb_user));
shadowing = kron(shadowing, ones(1,n_rb_user));

%% caculate interference power
% caculate shadowing
sub_power_array = 10.^((shadowing-path_loss)./10);
% caculate h
size_h = size(sub_power_array);
h = sqrt(0.5)*randn(size_h)+sqrt(0.5)*randn(size_h)*1j;
% final power array
channel_gain = (abs(h)).^2.*sub_power_array;
end