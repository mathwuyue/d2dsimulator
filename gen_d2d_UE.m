function [d1, d2, relay] = gen_d2d_UE(center, R, r)

% polar coordinates
r1 = rand(1,1);
r2 = rand(1,1);
user_pos_r = (R/3*max([r1;r2]))';
user_pos_theta = unifrnd(0,2*pi,1,1);

% casterian coordinates
xs = user_pos_r.*cos(user_pos_theta);
ys = user_pos_r.*sin(user_pos_theta);

% positions in top sector
user_pos_x = center(:,1) + xs;
user_pos_y = center(:,2) + ys;

% relay positions
relay = (user_pos_x + user_pos_y.*1i).';

% d1 d2
d1 = 0;
d2 = 0;
while (abs(d1-d2) < r)
    r1 = rand(1,2);
    r2 = rand(1,2);
    user_pos_r = (r*max([r1;r2]))';
    user_pos_theta = unifrnd(0,2*pi,2,1);
    
    % casterian coordinates
    xs = user_pos_r.*cos(user_pos_theta);
    ys = user_pos_r.*sin(user_pos_theta);
    
    % positions in top sector
    d1 = relay + (xs(1) + ys(1) * 1i);
    d2 = relay + (xs(2) + ys(2) * 1i);
end
end