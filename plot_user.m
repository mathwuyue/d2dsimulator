function plot_user(user_pos, color, marker)

scatter(real(user_pos),imag(user_pos), 66, color, 'LineWidth', 2, 'Marker', marker);
hold on;
end