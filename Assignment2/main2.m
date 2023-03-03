fig_num = 6;
l = 1.010;
rho = 3.054e-6;
sigma = rho/abs((l-1+rho)^3) + (1-rho)/abs((l+rho)^3);
part1 = sigma - 2;
part2 = sqrt(9*sigma^2 - 8*sigma);
lambda = sqrt((part1 - part2)/2);
omega = imag(lambda);
k = (omega^2 + 1 + 2*sigma) / (2 * omega);
disp(omega)
disp(k)

num_itr = 10000;
ot_list = linspace(0, 2*pi, num_itr);
x0 = 6.684e-5;
y0 = 0;
xdot0 = 0;
ydot0 = -k*x0*omega;
R0 = 1.496e8;
x = zeros(1, num_itr);
y = zeros(1, num_itr);
for i=1:num_itr
    ot = ot_list(i);
    x(i) = (x0 * cos(ot) + 1/k*y0*sin(ot)) * R0;
    y(i) = (y0*cos(ot) - k*x0*sin(ot)) * R0;
end

label_x = "km [m]";
label_y = "km [m]";
fig_title = "Orbit (XYPlane)";
fig_num = plot_2Dtrajectory(x, y, label_x, label_y, fig_title, fig_num);

%2-2************
r0 = [x0; y0; 0; xdot0; ydot0; 0];
dt = 1e-3;
time = 0:dt:2*pi/omega;
[T, Y] = ode45(@state_equation, time, r0);
plot(Y(1,1), Y(2,1), LineWidth=3);

fig_num = plot_2Dtrajectory(Y(:,1)*R0, Y(:,2)*R0, label_x, label_y, fig_title, fig_num);

time = 0:dt:2*pi/3/omega;
[T, Y] = ode45(@state_equation, time, r0);
plot(Y(1,1), Y(2,1), LineWidth=3);

fig_num = plot_2Dtrajectory(Y(:,1)*R0, Y(:,2)*R0, label_x, label_y, fig_title, fig_num);

