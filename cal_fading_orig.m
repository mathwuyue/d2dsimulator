function [fading_array] = cal_fading_orig(n_ctlos, n_ctnlos, rho_los, rho_nlos, n, los_idx_array, nlos_idx_array, n_base)
%% constants
% number of subcarriers
N_SC = 600;
% correlation parameter for los
RHO_LOS = rho_los;
% correlation parameter for nlos
RHO_NLOS = rho_nlos;
% n users in simulation
N_USER = n;
% How many base stations;
N_BS = n_base;

% calculate the number of correlation subcarriers. 
n_corr_los = n_ctlos;
n_corr_nlos = n_ctnlos;

%% generate correlation array for los and nlos
% LOS
corr_array_los_part = repmat(RHO_LOS.^(0:n_corr_los-1),n_corr_los,1);
corr_array_los_part = corr_array_los_part ./ repmat((RHO_LOS.^(0:n_corr_los-1))',1,n_corr_los);
corr_array_los_part(corr_array_los_part > 1) = 0;
corr_array_los_part(2:end,:) = corr_array_los_part(2:end,:)*(1-RHO_LOS);
% i array of sparse matrix
i_vector = kron(1:N_SC, ones(1,n_corr_los));
j_vector = reshape(kron(reshape(1:N_SC, n_corr_los, N_SC/n_corr_los), ones(1, n_corr_los)), 1, N_SC*n_corr_los);
corr_array_los = sparse(i_vector, j_vector, repmat(reshape(corr_array_los_part',1,n_corr_los^2), 1, N_SC/n_corr_los));
% corr_array_los = sparse(kron(eye(N_SC/n_corr_los), corr_array_los_part));
% NLOS
corr_array_nlos_part = repmat(RHO_NLOS.^(0:n_corr_nlos-1),n_corr_nlos,1) ./ repmat((RHO_NLOS.^(0:n_corr_nlos-1))',1,n_corr_nlos);
corr_array_nlos_part(corr_array_nlos_part > 1) = 0;
corr_array_nlos_part(2:end,:) = corr_array_nlos_part(2:end,:)*(1-RHO_NLOS);
i_vector = kron(1:N_SC, ones(1,n_corr_nlos));
j_vector = reshape(kron(reshape(1:N_SC, n_corr_nlos, N_SC/n_corr_nlos), ones(1, n_corr_nlos)), 1, N_SC*n_corr_nlos);
corr_array_nlos = sparse(i_vector, j_vector, repmat(reshape(corr_array_nlos_part',1,n_corr_nlos^2), 1, N_SC/n_corr_nlos));
% corr_array_nlos = kron(eye(N_SC/n_corr_nlos), corr_array_nlos_part);

%% generate the correlation matrix. Need For loop for each Matrix
% set up h matrix
fading_array = ones(N_BS, N_SC*N_USER);
% set up user index array
user_idx = 1:N_USER;

% BEGIN FOR LOOP
for i = 1:N_BS
    los_idx = los_idx_array(i,:);
    nlos_idx = nlos_idx_array(i,:);
    % How many LOS users
    N_LOS = sum(los_idx);
     % group user by LOS and NLOS
    user_group_idx = [user_idx(los_idx),user_idx(nlos_idx)];
    raw_fading_array = sqrt(0.5)*randn(1, N_SC*N_USER)+sqrt(0.5)*randn(1, N_SC*N_USER)*1j;
    % generate the los part
    for j = 1:N_LOS
        % generate raw_fading_array
%         raw_fading_array = sqrt(0.5)*randn(N_SEC, N_SC)+sqrt(0.5)*randn(N_SEC, N_SC);
        % original user index
        osi = user_group_idx(j);
        fading_array(i, (osi-1)*N_SC+1:osi*N_SC) = raw_fading_array((j-1)*N_SC+1:j*N_SC) * corr_array_los;
    end
%     corr_matrix_los = kron(sparse(eye(N_LOS)), corr_array_los);
    % generate the nlos part
    for j = N_LOS+1:N_USER
        % generate raw_fading_array
%         raw_fading_array = sqrt(0.5)*randn(N_SEC, N_SC)+sqrt(0.5)*randn(N_SEC, N_SC);
        % original user index
        osi = user_group_idx(j);
        fading_array(i, (osi-1)*N_SC+1:osi*N_SC) = raw_fading_array((j-1)*N_SC+1:j*N_SC) * corr_array_nlos;
    end
end
end