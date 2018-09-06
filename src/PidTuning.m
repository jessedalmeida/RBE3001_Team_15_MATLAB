%% First time setup for the packets and constants
init;
pp = PacketProcessor(myHIDSimplePacketComs);

%for link 1 pid of .0025, 0, 0
%for link 2, pid of .0025, 0, .028 works well +/-3deg
%for link 3, pid of .0025, 0 , .02
%% Sets the pid values for each of the arms before moving to the setpoint
% for pid2 i = .01
jToSet1=zeros(3,1,'single');
jToSet1=[0.3 0 0.25];
jToSet2=zeros(3,1,'single');
jToSet2=[0.3 0 0.25];
jToSet3=zeros(3,1,'single');
jToSet3=[0.3 0 0.25];
PIDConfig(pp, jToSet1, jToSet2, jToSet3);
%% Moves the robot to the setpoint (in degrees) for each of the joints.
Setpoint(pp,-20,13,20);
% pause(2);
% Setpoint(pp,0,0,0);
pp.shutdown();
clear