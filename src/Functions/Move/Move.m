function Move(pp, algorithm, setPos, curPos, startTime, toffset)
%MOVE takes in a taskspace position and the name of the algorithm to use
%and uses that alg to move

switch algorithm
    case 'trajectoryBlocking'
        MoveToPointTrajBlocking(pp, setPos);
    case 'trajectory'
        MoveTraj(pp, setPos, curPos, startTime, toffset);
    case 'ivel'
        MoveiVel(pp, setPos, curPos, startTime, toffset);
    otherwise
        MoveToPoint(pp, setPos);
end

