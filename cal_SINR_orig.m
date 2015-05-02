function [SINR_array] = cal_SINR_orig(power_array, interference_array)
%% CONSTANT
BW = 10e6;
BOLTZ = 1.3806488e-23;
N_SC = 600;

% CELL_IDX = kron(cell_idx, ones(1, N_SC));
%% get the idx which the user is not served by the cell
% tmp = max_idx - CELL_IDX;
% idx = (tmp < 0) & (tmp > 2);
% get users that are served by the cell
% max_power = max_power(idx);
% max_idx = max_idx(idx);
interference = sum(interference_array);
% sum_power_array = sum_power_array(idx);

%% [u1_sc1, u1_sc2,...u1_sc1200,u2_sc1...u2_sc1200,....u30_sc1200] 
SINR_array = power_array ./ (interference + BOLTZ*293*BW/N_SC);
end