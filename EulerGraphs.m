%Constants
TRUE = 1;
FALSE = 0;

%Graph initialization
pt = [0 0 0];
dir = [1 0 0 1];
h = quiver3(pt(1),pt(2),pt(3), dir(1),dir(2),dir(3),'linewidth', 7);
xlim([-1 1])
ylim([-1 1])
zlim([-1 1])

%CHANGE FILENAME HERE%
%File for sensor on finger - Sensor A 
filename ='C:\Users\Amira\Downloads\Data Collection V1 Raw Data\Amira\46_AmiraLoc2Fe_2017-11-09T15.35.31.725_D4F2563AA28E_Quaternion.xlsx';
time = xlsread(filename,'Euler Angles','A4000:A6500');
phi = xlsread(filename,'Euler Angles','B4000:B6500');
theta = xlsread(filename,'Euler Angles','C4000:C6500');
psi = xlsread(filename,'Euler Angles','D4000:D6500');


%File for sensor on wrist - Sensor B
%filename ='C:\Users\Amira\Downloads\Data Collection V1 Raw Data\Amira\59_AmiraLoc5ps_2017-11-09T16.02.19.297_D4F2563AA28E_Quaternion.xlsx';
%quatW = xlsread(filename,'Raw Data','D2:D5000');
%quatX = xlsread(filename,'Raw Data','E2:E5000');
%quatY = xlsread(filename,'Raw Data','F2:F5000');
%quatZ = xlsread(filename,'Raw Data','G2:G5000');

%Initializing Peak Detector Values
[rows, columns] = size(phi);
disp('Starting Peak Detector')
rollingAvg = 0;
recentDataArrPsi = zeros(1,20);
increasing = FALSE;
index = 0;
pastRollingAvg = 0;
numReps = 0;
pastTime = time(2);

%Cycle through each row and calculate position in 3D space
for row = 3 : rows
    
    %Add value to circular array, by finding next index then adding element
    index = (index + 1);
    index = rem(index,19) + 1;
    
    recentDataArrPsi(index) = psi(row);
    
    currTime = time(row);
    
    %Calculate average in circular array
    rollingAvg = 0;
    for i = 1:20
        rollingAvg = rollingAvg + recentDataArrPsi(i);
    end
    rollingAvg = rollingAvg/20;
    
    %check when current point is less than average in the array
    if pastRollingAvg < rollingAvg
        increasing = TRUE;
    end
    
    if increasing == TRUE
        if psi(row) < (rollingAvg)
            numReps = numReps + 1;
            timeElapsed = currTime - startTime;
            str = ['Peak: ', num2str(numReps)];%, ' Exercise took', num2str(timeElapsed*1000), ' (milliseconds)'];
            disp(str)
            increasing = FALSE;
        end
    end
    
    pastRollingAvg = rollingAvg;
    startTime = currTime;

    %3D graph vector
    xfm = makehgtform('zrotate',phi(row),'yrotate',theta(row),'zrotate',psi(row));
    newdir = xfm * dir';
    h.UData = newdir(1);
    h.VData = newdir(2);
    h.WData = newdir(3);
    drawnow
end
