% model parameters:
close all;
for i = 2:6 %%% plots changes in variables and the cart for 5 random positions of pendulum
theta_init = -1.5 + 3 * rand;%-1.15;% % initial angle of pole (in radians)
angle_velo = 0;%-4 + 8 * rand;
x_init = 0;     % initial cart position (in m)
g = 9.81;       % gravitational acceleration (in m/s^2)
m_c = 1;        % mass of cart (in kg)
m_p = 0.1;      % mass of pole (in kg)
l = 2;        % distance from pivot to pole center (length = 2*l)
h_max = 25;    % maximal deviation in cart position (in m)
r_max = pi/2;   % maximal deviation in pole angle (in radians=approx. 12°)
tau = 0.01;     % time step (in s)

% read controller from file:
myController = readfis('controller_2inputs');
% drawPendulum([0,theta_init,0]);

% simulation parameters:
simulationTime = 1; % (in s)

numOfStableSteps = simulate(i, theta_init, angle_velo, x_init, g, m_c, m_p, l, ...
    h_max,r_max, tau, simulationTime, myController);
% plotting:
subplot(4,1,1);
title('position');
hold off;
subplot(4,1,2);
title('dx/dt');
hold off;
subplot(4,1,3);
title('angle');
hold off;
subplot(4,1,4);
title('d\theta/dt');
hold off;
end


