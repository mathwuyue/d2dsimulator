function cc_power = cal_cc_tps(d, pping, epsilon, alpha)
cc_power = pping * (d).^(alpha * epsilon);
end