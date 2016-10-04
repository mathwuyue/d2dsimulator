function d = cal_d2d_resuse_d_c (pping, pmax, lambda, rho, threshold, epsilon, alpha)
d = (pping./(threshold*pmax) .* (-alpha*log(rho)/(2*lambda*pi^2*csc(2*pi/alpha))).^(alpha/2)).^(1./(alpha*(1-epsilon)));
end