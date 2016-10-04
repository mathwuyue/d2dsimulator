function throughput = cal_d2d_throughput(x, nargs, d2d_g, cc_interference)
% constants
a = 2.27;
b = 13;
c = 40;

chi = x(1:nargs);
d2d_tps = x(nargs+1:2*nargs);
d2d_rps = d2d_tps .* d2d_g;
d2d_SINR = cal_SINR_orig(d2d_rps, cc_interference);
throughput = a*sum(chi .* atan(d2d_SINR+b/c));
end