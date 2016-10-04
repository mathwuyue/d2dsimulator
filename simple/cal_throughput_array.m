%% n is the whole cell's user number.

function [throughput_array, rb_throughput_array] = cal_throughput_array(SINR_array, threshold)
% constants
N_RB = 50;

%% calculate each subcarrier's data rate. Using the Table in Book of Assumption.
throughput_array = zeros(size(SINR_array));
% db SINR_array
db_SINR_array = 10*log10(SINR_array);
% get the idxs for each data rate
idx = [db_SINR_array <= threshold, ...,
 db_SINR_array > threshold & db_SINR_array <= -4.06, ...,
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
data_rate_array = [0 0.31, 1.21, 2.77, 4.18, 4.75, 5.39, 7.07, 7.17, 8.66, 10.2, 13.89, 15.75, 16, 18.84, 19.8, 20.9, 26.54, 29.35,29.79, 34.72, 36.67, 37.5, 37.65, 39.46, 40.98, 41.9, 42.64, 43.07, 43.2] / N_RB;
% calcualte the throuput according to each subcarrier's SINR
for i = 1:length(data_rate_array)
    colon1 = colon((i-1)*N_RB+1, i*N_RB);
    throughput_array(idx(:, colon1)) = data_rate_array(i);
end

%% get rb throughput array
rb_throughput_array = throughput_array * 11 / 14;