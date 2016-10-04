function [user_pos] = gen_user_ul(center,n,r)
% constants
R = r;

% polar coordinates
r1 = rand(1, n);
r2 = rand(1, n);
user_pos_r = (R*max([r1;r2]))';
user_pos_theta = unifrnd(0,2*pi,n,1);

% each sector sort its user_pos_r:
% tmp_pos_r = sort(reshape(user_pos_r, n, 3));
% user_pos_r = reshape(tmp_pos_r, 3*n, 1);

% casterian coordinates
xs = user_pos_r.*cos(user_pos_theta);
ys = user_pos_r.*sin(user_pos_theta);

% positions in top sector
user_pos_x = xs + center(1);
user_pos_y = ys + center(2);

% user positions
user_pos = (user_pos_x + user_pos_y.*1i).';
end