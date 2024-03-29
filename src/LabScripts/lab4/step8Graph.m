%% Initialize Servers and Points
init;

handleGetter=GraphSingleton();
writer=CSVWriter();
fileName=writer.BeginCsv('sims8');


LivePlot3D([0,0,0], true);
pause(.1);
          
prevjPoint=[0,0,0];
LivePlot3D(prevjPoint, false, true);
prevPoint = fwkin(0,0,0)';

%% Initialize it to 3rd Setpoint
% To make the csv cleaner
pause(.5);

secPerPoint=1;
totalTime=0;

%% Loop through each setpoint
while 1
    [loc]=ginput3d(1);
    disp(loc);
    % initial and final joint angles required for the trajectory
    % Gets the setPos in terms of x,y,z (not joint angles)
    setjPos = ikin(loc);
    runTime=0;

    % Get the velocity for each of the setpoints based off the time
    % for each point
    curjPos = prevjPoint;
    
    velToSet=(loc-prevPoint)/secPerPoint; %velocity in deg/sec
    jointVels=pivel(curjPos, velToSet');
    
    nextjPos=zeros(1, 3, 'single');
    
    % While the time in the current setpoint is less than the time allotted
    % for the setpoint
    while runTime < secPerPoint
        % get the timestamp set up and let the arm move for a bit
        % using the pause
        tic;
        
        LivePlot3D(curjPos, false, true);

        timeSpan=toc;
        
        % Set up the next setpoint using the velocity found above
        % and integrate the velocity using the timespan
        for j=1:3
            nextjPos(j)=setjPos(j)+jointVels(j)*timeSpan;
        end
        
        % Move the robot to the setpoint and increase runtime
        curjPos = nextjPos;        
        timeSpan=toc;
        runTime=runTime+timeSpan;
        totalTime=totalTime+timeSpan;
        
        %creates a csv with time, cartisian velocities, tip magnitude, and
        %joint velocities
        %data= [totalTime cartisianVel norm(cartisianVel) jointVels(1:3, 1)' ];
       % writer.AppendCsv(fileName, data);
    end
    
    % reset previous point for the next run
    prevjPoint=setjPos;
    prevPoint = loc;
end
clear