function d2d_radius = cal_d2d_radius(p_d2d, p_c, pmax, r_d, r_c, theta_d, theta_c, theta_r, threshold, rho, lambda, alpha)

f = @(x) exp(2.*lambda.*pi^2/alpha.*(p_d2d./(threshold.*pmax)).^(-2/alpha).*csc(2*pi/alpha).*x.^2).*(threshold.*p_c.*sqrt((r_c.*cos(theta_c)-x.*cos(theta_r)-r_d.*cos(theta_d)).^2+(r_c.*sin(theta_c)-x.*sin(theta_r)-r_d.*sin(theta_d)).^2).^(-alpha).*x.^alpha+p_d2d)-p_d2d/rho;

x0 = 100*ones(size(r_d));
%d2d_radius = exp(2.*lambda.*pi^2/alpha.*(p_d2d./(threshold.*pmax)).^(-2/alpha).*csc(2*pi/alpha).*x0.^2).*(threshold.*p_c.*sqrt((r_c.*cos(theta_c)-x0.*cos(theta_r)-r_d.*cos(theta_d)).^2+(r_c.*sin(theta_c)-x0.*sin(theta_r)-r_d.*sin(theta_d)).^2).^(-alpha).*x0.^alpha+p_d2d)-p_d2d/rho;
d2d_radius = fsolve(f,x0);
end