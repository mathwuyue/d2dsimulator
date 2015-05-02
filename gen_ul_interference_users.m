function [user_pos] = gen_ul_interference_users(centers,n,r)
% constants
N_SEC = 3;
R = r/3.0;

sector_centers = kron(centers, ones(1,N_SEC*n)) + repmat([complex(0,R),complex(-sqrt(3)/2*R,-0.5*R),complex(sqrt(3)/2*R,-0.5*R)], 1, n*length(centers));

% polar coordinates
user_pos_r1 = unifrnd(0,R,1,length(centers)*N_SEC*n);
user_pos_r2 = unifrnd(0,R,1,length(centers)*N_SEC*n);
user_pos_r = max([user_pos_r1;user_pos_r2]);
user_pos_theta = unifrnd(0,2*pi,1,N_SEC*n*length(centers));

% each sector sort its user_pos_r:
% tmp_pos_r = sort(reshape(user_pos_r, n, 3));
% user_pos_r = reshape(tmp_pos_r, 3*n, 1);

% casterian coordinates
xs = user_pos_r.*cos(user_pos_theta);
ys = user_pos_r.*sin(user_pos_theta);

% shifts
shifts = complex(xs, ys);

% user positions
user_pos = sector_centers+shifts;

% select n users for each cell
idx_rows = randsample(1:n*N_SEC, n);
user_pos = reshape(user_pos, n*N_SEC, length(centers));
user_pos = user_pos(idx_rows, :);
user_pos = user_pos.';
end