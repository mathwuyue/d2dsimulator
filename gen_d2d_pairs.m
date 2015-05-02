function [tr_ue, rc_ue] = gen_d2d_pairs(center, dist_d2d, n_pair, isd)
% constant
R = isd;

%% generate transimit UE locations

% polar coordinates
r1 = rand(1,n_pair);
r2 = rand(1,n_pair);
user_pos_r = R*max([r1;r2])';
user_pos_theta = unifrnd(0,2*pi,n_pair,1);



% casterian coordinates
xs = user_pos_r.*cos(user_pos_theta);
ys = user_pos_r.*sin(user_pos_theta);

% positions in top sector
user_pos_x = center(1) + xs;
user_pos_y = center(2) + ys;

% user positions
tr_ue = (user_pos_x + user_pos_y.*1i).';

%% generate receive UE locations
% generate angle and radius
theta = unifrnd(0, 2*pi, n_pair, 1);
% shift_radius = unifrnd(0, dist_d2d, 1, n_pair);
shift_radius_tmp = unifrnd(0, dist_d2d, 2, n_pair);
shift_radius = max(shift_radius_tmp)';
% shifts
shifts = (shift_radius.*cos(theta)+shift_radius.*sin(theta)*1i).';
% rc_ue locations
rc_ue = tr_ue + shifts;
end