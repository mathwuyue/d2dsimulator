function [cc_throughput, d2d_throughput] = cal_d2d_throughput_fair_rr (d2d_SINR_array, cc_SINR_array, n_d2d, n_cc)
% constants
N_SC = 600;
N_RB = 50;

SINR_array = [d2d_SINR_array, cc_SINR_array];
n = n_cc + n_d2d;

%% how many subcarriers for each UE:
n_user_RB = ceil(N_RB/n);
n_user_SC = n_user_RB * N_SC / N_RB;
user_RB_allocation = (uint16([n_user_RB,n_user_RB-1;1,1]\[N_RB, n]'));

%% RB allocation
RB_allocation_array = zeros(N_SC, n);
colon1 = colon(1,n_user_SC*user_RB_allocation(1));
colon2 = colon(1,user_RB_allocation(1));
RB_allocation_array(colon1, colon2) = kron(eye(user_RB_allocation(1)), ones(n_user_SC,1));
colon1 = colon(n_user_SC*user_RB_allocation(1)+1, N_SC);
colon2 = colon(user_RB_allocation(1)+1, n);
RB_allocation_array(colon1, colon2) = kron(eye(user_RB_allocation(2)), ones(n_user_SC-N_SC/N_RB, 1));

%% calculate each subcarrier's data rate. Using the Table in Book of Assumption.
throughput_array = zeros(1, N_SC*n);
% db SINR_array
db_SINR_array = 10*log10(SINR_array);
% get the idxs for each data rate
idx = [db_SINR_array <= -4.06, ...,
 db_SINR_array > -4.06 & db_SINR_array <= -2.06, ...,
 db_SINR_array > -2.06 & db_SINR_array <= -0.06, ...,
 db_SINR_array > -0.06 & db_SINR_array <= 1.94, ...,
 db_SINR_array > 1.94 & db_SINR_array <= 3.20, ...,
 db_SINR_array > 3.20 & db_SINR_array <= 3.7, ...,
 db_SINR_array > 3.7 & db_SINR_array <= 5.7, ...,
 db_SINR_array > 5.7 & db_SINR_array <= 5.9, ...,
 db_SINR_array > 5.9 & db_SINR_array <= 6.95, ...,
 db_SINR_array > 6.95 & db_SINR_array <= 8.75, ...,
 db_SINR_array > 8.75 & db_SINR_array <= 10.71, ...,
 db_SINR_array > 10.71 & db_SINR_array <= 12.71, ...,
 db_SINR_array > 12.71 & db_SINR_array <= 13.5, ...,
 db_SINR_array > 13.5 & db_SINR_array <= 14.47, ...,
 db_SINR_array > 14.47 & db_SINR_array <= 15.00, ...,
 db_SINR_array > 15.00 & db_SINR_array <= 15.26, ...,
 db_SINR_array > 15.26 & db_SINR_array <= 17.26, ...,
 db_SINR_array > 17.26 & db_SINR_array <= 20.13, ...,
 db_SINR_array > 20.13 & db_SINR_array <= 20.23, ...,
 db_SINR_array > 20.23 & db_SINR_array <= 22.23, ...,
 db_SINR_array > 22.23 & db_SINR_array <= 24.23, ...,
 db_SINR_array > 24.23 & db_SINR_array <= 26.23, ...,
 db_SINR_array > 26.23 & db_SINR_array <= 27.80, ...,
 db_SINR_array > 27.80 & db_SINR_array <= 28.81, ...,
 db_SINR_array > 28.81 & db_SINR_array <= 30.81, ...,
 db_SINR_array >30.81 & db_SINR_array <= 32.81, ...,
 db_SINR_array > 32.81 & db_SINR_array <= 34.81, ...,
 db_SINR_array > 34.81 & db_SINR_array <= 36.81, ...,
 db_SINR_array > 36.81 & db_SINR_array <= 38.81, ...,
 db_SINR_array > 38.81];
% data rate array (Mbps)
data_rate_array = [0.31, 1.21, 2.77, 4.18, 4.75, 5.39, 7.07, 7.17, 8.66, 10.2, 13.89, 15.75, 16, 18.84, 19.8, 20.9, 26.54, 29.35,29.79, 34.72, 36.67, 37.5, 37.65, 39.46, 40.98, 41.9, 42.64, 43.07, 43.2] *2 / N_SC;
% calcualte the throuput according to each subcarrier's SINR
for i = 1:length(data_rate_array)
    colon1 = colon((i-1)*N_SC*n+1, i*N_SC*n);
   throughput_array(idx(:, colon1)) = data_rate_array(i);
end

%% generate the array to sum subcarrier data rate
% [u1_sc1,u1_sc2...u1_sc1200;...un_sc1,un_sc2,...un_sc1200]
throughput_array = reshape(throughput_array, N_SC, n)';
ue_throughput_array = throughput_array * RB_allocation_array;
% get diagonal elements (Mbps)
ue_throughput = diag(ue_throughput_array)*11/14;

%% total throughput
d2d_throughput = sum(ue_throughput(1:n_d2d));
cc_throughput = sum(ue_throughput(n_d2d+1:n));
end