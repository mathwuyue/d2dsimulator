function [user_pos] = gen_user_ul(center,n,r)
% constants
R = r/3.0;
sector_centers = repmat([center(1),center(2)+R; center(1)-sqrt(3)/2*R,center(2)-0.5*R; center(1)+sqrt(3)/2*R, center(2)-0.5*R], n, 1);
% polar coordinates
r1 = rand(1,3*n);
r2 = rand(1,3*n);
user_pos_r = (R*max([r1;r2]))';
user_pos_theta = unifrnd(0,2*pi,3*n,1);

% each sector sort its user_pos_r:
% tmp_pos_r = sort(reshape(user_pos_r, n, 3));
% user_pos_r = reshape(tmp_pos_r, 3*n, 1);

% casterian coordinates
xs = user_pos_r.*cos(user_pos_theta);
ys = user_pos_r.*sin(user_pos_theta);

% positions in top sector
user_pos_x = sector_centers(:,1) + xs;
user_pos_y = sector_centers(:,2) + ys;

% user positions
user_pos = (user_pos_x + user_pos_y.*1i).';

% select exact n samples randomly
user_pos = randsample(user_pos, n);
end