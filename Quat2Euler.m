%replace file name here!
filename ='C:\Users\Amira\Downloads\Data Collection V1 Raw Data\Amira\46_AmiraLoc2Fe_2017-11-09T15.35.31.725_D4F2563AA28E_Quaternion.xlsx';
%'C:\Users\Amira\Documents\Capstone\MATLAB PROJECT\test.xlsx';

%retrieve data in columns
quatW = xlsread(filename,'D:D');
quatX = xlsread(filename,'E:E');
quatY = xlsread(filename,'F:F');
quatZ = xlsread(filename,'G:G');

%calculate Euler Angles, and Rotation Matrices
quatMat = [quatW quatX quatY quatZ];
eulZYZ = quat2eul(quatMat,'ZYZ');
plot3(eulZYZ(1), eulZYZ(2), eulZYZ(3));
rotm = quat2rotm(quatMat);

sheet = 'Euler Angles';
headers = {'First - phi (?)','Second - theta (?)','Third - psi(?)'};
xlswrite(filename,[headers; num2cell(eulZYZ)], sheet);


