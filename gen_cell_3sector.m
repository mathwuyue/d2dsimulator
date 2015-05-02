function [c_centers]=gen_cell_3sector(r, n)
centers = zeros(1+(6+(n-1)*6)*(n-1)/2,2);
for i = 1:n
    if i == 1
        centers(1,:)=[0,0];
        continue;
    end
    R = (i-1)*r;
    x_endpoints = [0, 3^0.5/2*R, 3^0.5/2*R, 0, -3^0.5/2*R, -3^0.5/2*R];
    y_endpoints = [R, 0.5*R, -0.5*R, -R, -0.5*R, 0.5*R];
    if i == 2
        centers(2:7,:) = vertcat(x_endpoints,y_endpoints)';
        continue;
    end
    x_tmp = x_endpoints(2) / (i-1);
    y_tmp1 = R / (i-1);
    y_tmp2 = R / (2*(i-1));
    times = 0:(i-2);
    x = [zeros(1,i-1)+x_tmp*times,ones(1,i-1)*x_endpoints(2),x_endpoints(3)*ones(1,i-1)-x_tmp*times,-x_tmp*times,x_endpoints(5)*ones(1,i-1),x_endpoints(6)*ones(1,i-1)+x_tmp*times];
    y = [R*ones(1,i-1)-y_tmp2*times, y_endpoints(2)*ones(1,i-1)-y_tmp1*times,y_endpoints(3)-y_tmp2*times,y_endpoints(4)*ones(1,i-1)+y_tmp2*times, y_endpoints(5)*ones(1,i-1)+y_tmp1*times, y_endpoints(6)*ones(1,i-1)+y_tmp2*times];
    centers(2+(6+(i-2)*6)*(i-2)/2:1+(6+(i-1)*6)*(i-1)/2,:) = vertcat(x,y)';
end
c_centers = complex(centers(:,1), centers(:,2)).';
end