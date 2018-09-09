function LivePlot3D(q, start)
%% Initialize the figure 
if start
    constants;
    axes1 = axes('Parent',figure);
    hold(axes1,'on');
    
    % Create xlabel
    xlabel('X');
    
    % Create zlabel
    zlabel('Z');
    
    % Create ylabel
    ylabel('Y');
    
    xlim(axes1,[-100 400]);
    ylim(axes1,[-250 250]);
    zlim(axes1,[-100 400]);
    view(axes1,[-156.7 8.40000000000001]);
    box(axes1,'on');
    grid(axes1,'on');
    
    set(axes1,'Color',[0.941176474094391 0.941176474094391 0.941176474094391]);
    disp("Initializing Plot")
    
elseif ~start
    %% Create Plot
    L1 = 135; L2 = 175; L3 = 169.28;
    
    T01 = DHSolver(0, -90, L1, -q(1));
    T12 = DHSolver(L2, 0, 0, -q(2));
    T23 = DHSolver(L3, 0, 0, -q(3) + 90);
    
    T02 = T01 * T12;
    T03 = T02 * T23;
    
    z = zeros(3, 1, 'single');
    p01 = T01(1:3,4);
    p12 = T02(1:3,4);
    p23 = T03(1:3,4);
    
    framePos = [z p01 p12 p23];
    
    q = double(q);
    lastPoint = double(p23);
    
    label = sprintf('Joint 1: %0.0f \nJoint 2: %0.0f \nJoint 3: %0.0f', q(1), q(2), q(3));
    
    handleGetter=GraphSingleton();
    R=handleGetter.getHandle();
    t = handleGetter.getGraphText();
    set(t,'Position', lastPoint, 'String', label);
    set(R.handle, 'xdata', framePos(1,:), 'ydata', framePos(2,:), 'zdata', framePos(3,:));
    drawnow();
    
    
end
end

