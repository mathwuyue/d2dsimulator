function p_max_d = cal_p_max_d2d(d_c,d2d_rt,pc,pmax,threshold,rho,lambda,alpha)
p_max_d = pc/threshold * (d2d_rt./d_c).^alpha * (1/rho*exp(-2*lambda*pi^2/alpha*(threshold*pmax/(pc*d_c^(-alpha)))^(2/alpha)*csc(2*pi/alpha)) - 1);
p_max_d = min(pmax, p_max_d);
end