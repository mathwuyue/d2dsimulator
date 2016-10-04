function recv_p = cal_recv_p(trs,recvs, ptotal, freq, alpha)
%% calculate distances between d2d UEs and CC UEs.
dist_inter_users = abs(trs - recvs);

%%  calculate pathloss and shadowing
pathloss = alpha*10*log10(dist_inter_users) + 22.7 + 26*log10(freq);
shadowing = 4*ones(size(dist_inter_users));
shadowing = shadowing.*randn(size(shadowing));

% caculate receive power
r_p = ptotal - pathloss + shadowing;

%% caculate interference power
% caculate shadowing
sub_power_array = 10.^(r_p./10);
% caculate h
size_h = size(sub_power_array);
h = sqrt(0.5)*randn(size_h)+sqrt(0.5)*randn(size_h)*1j;

% final power array
recv_p = (abs(h)).^2.*sub_power_array;
end