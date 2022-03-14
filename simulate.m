function numOfStableSteps = simulate(i, theta_init, angle_velo, x_init, g, m_c, m_p, ...
    l,h_max,r_max, tau, simulationTime, fisController)

    %%% drawing the pendulum
    % drawing parameters
    L = 5;
    gap = 0.01;
    width = 4;
    height = 2;
    y = 0;
    theta= theta_init;

    % making the figure with the width from -25 , 25
    figure(1), clf
    track_width = 25;
    plot([-track_width,track_width],[0,0],'k');
%     % define persistent variables
%     persistent base_handle
%     persistent rod_handle
    % plot track
    hold on
    base_handle = drawBase(y,width,height,gap,[],'normal');
    rod_handle= drawRod(y,theta,L,gap,height,[],'normal');
    axis([-track_width,track_width,-L,2*track_width-L]);

    % simulation parameters:
    numTimeSteps = simulationTime/tau;

    % initial values:
    angle_theta = theta_init;
    pos_x = x_init;
    pos_velo = 0;

    numOfStableSteps = 0;
    for t=1:numTimeSteps
        drawnow;
        F = myFuzzyController_2inputs(angle_theta, angle_velo, fisController);
        angle_acc = getAngleAccelaration(g, angle_theta, angle_velo, F, m_p, m_c, l);
        pos_acc = getPosAccelaration(F, m_p, l, angle_velo, angle_theta, angle_acc, m_c);
        
        % integration step of Euler method:
        angle_theta = angle_theta + tau.*angle_velo;
        angle_velo = angle_velo + tau.*angle_acc;
        pos_x = pos_x + tau.*pos_velo;
        pos_velo = pos_velo + tau.*pos_acc;
          
        drawBase(pos_x,width,height,gap,base_handle,'normal');
        drawRod(pos_x,angle_theta,L,gap,height,rod_handle,'normal');
        
        %%% check if we are out of bound or pendulum has fallen to stop
        if (pos_x < -h_max || pos_x > h_max || ...
                angle_theta < -r_max || angle_theta > r_max)
            fprintf('Current state of pole not stable after %e seconds\n', t*tau);
            fprintf('   x_%d = %e; theta_%d = %e\n', t, pos_x, t, angle_theta);
            break;
        end
        
        numOfStableSteps = numOfStableSteps + 1;
       
        if mod(t,100) == 0
            fprintf('iteration %d\n', t);
        end
        %%% drawing plots and showing the changes in variables to the
        %%% balanced point
        figure(i);
        subplot(4,1,1);
        plot(t*tau,pos_x,'xb');
        hold all;
        subplot(4,1,2);
        plot(t*tau,pos_velo,'og');
        hold all;
        subplot(4,1,3);
        plot(t*tau,angle_theta,'xr');
        hold all;
        subplot(4,1,4);
        plot(t*tau,angle_velo,'om');
        hold all;
    end
end