function plot_cell_3sector(centers, r, n, iscolor)
close all;
color = 'cyb';
R = r/3;
for i = 1:n
    if i == 1
        cells = 1;
        start = 0;
    else
        cells = (i-1)*6;
        start = 1+(6+(i-2)*6)*(i-2)/2;
    end
    layer_color = color(rem(i,3)+1);
    for j=1:cells
        c = repmat(centers(start+j,:),3,1) + [[0,R];[-sqrt(3)/2*R,-0.5*R];[sqrt(3)/2*R,-0.5*R]];
        for k=1:3
            theta=pi/2:pi/3:2.5*pi;
            xx=c(k,1) + R*cos(theta);
            yy=c(k,2) + R*sin(theta);
            plot(xx,yy, 'k', 'LineWidth',2);
            if iscolor
                 fill(xx,yy,layer_color);
            end
            axis square
            hold on;
        end
    end
end