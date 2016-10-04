function [d2d_tr, d2d_rc] = gen_d2d_pair(rt, d, mode)
% mode: 1 random rt. 2 fixed rt
switch mode
    case 1
        d2d_rt = unifrnd(0,rt,1);
    case 2
        d2d_rt = rt;
end
% theta
user_pos_theta = unifrnd(0,2*pi,2,1);
% d2d_tr
d2d_tr = d2d_rt * cos(user_pos_theta(1)) + d2d_rt * sin(user_pos_theta(1)) * 1i;
% d2d_rc
% delta = rand(1,1);
% r = sqrt((d^2-r1^2)*delta+r1^2);
% x = r * cos(user_pos_theta(2));
% y = r * sin(user_pos_theta(2));
r_shift = d * cos(user_pos_theta(2)) + d * sin(user_pos_theta(2)) * 1i;
d2d_rc = d2d_tr + r_shift;
end