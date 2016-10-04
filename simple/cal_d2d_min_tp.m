function p_min_d2ds = cal_d2d_min_tp(g_d, cc_interference, inter_interference, threshold, n)
p_min_d2ds = threshold .* (cc_interference + kron(inter_interference, ones(1,n))) ./ g_d;
end