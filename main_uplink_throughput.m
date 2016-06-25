global N_SC N_SEC N_RB;
N_SC = 600;
N_SEC = 3;
N_RB = 50;

%% constant                                               % each scenario loops 1000 times
PTOTAL = -7;
FREQ = 2.15;
SCENARIO = 2;
IS_LOS =1;
ISD = 500;
N_USERS = [3,6,10,15,20];
N_TIER = 3;
LOOP = 1000;

centers = gen_cell_3sector(ISD, N_TIER);

uplink_user_throughput = zeros(1, 5);
j=1;

for N_USER = N_USERS
    orig_throughput_tmp = (0);
    for i=1:LOOP
        users_pos = gen_user([0,0], N_USER, ISD);
        orig_subcarrier_power_array = cal_power_orig(users_pos, SCENARIO, IS_LOS, PTOTAL, FREQ);
        orig_subcarrier_interference_array = cal_interference_orig(centers, ISD, N_USER, SCENARIO, IS_LOS, PTOTAL, FREQ);
        orig_SINR_array = cal_SINR_orig(orig_subcarrier_power_array, orig_subcarrier_interference_array);
        % calcualte the overall throughput
        [orig_throughput, ~] = cal_throughput_fair_rr(orig_SINR_array, N_USER*N_SEC);
        orig_throughput_tmp = orig_throughput_tmp + orig_throughput;
    end
    uplink_user_throughput(j) = orig_throughput_tmp / LOOP;
    j = j+1;
end
overall_uplink_user_throughput = (uplink_user_throughput);
