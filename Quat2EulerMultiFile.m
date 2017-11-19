%replace file name here!
filename = 'C:\Users\Amira\Documents\Capstone\MATLAB PROJECT\test.xlsx';
start_path = fullfile('C:\Users\Amira\Downloads');

% Ask user to confirm the folder, or change it.
uiwait(msgbox('Pick a starting folder on the next window that will come up.'));
topLevelFolder = uigetdir(start_path);

filePattern = sprintf('%s/**/*.xlsm', topLevelFolder);
allFileInfo = dir(filePattern);

% Throw out any folders.  We want files only, not folders.
isFolder = [allFileInfo.isdir]; % Logical list of what item is a folder or not.
% Now set those folder entries to null, essentially deleting/removing them from the list.
allFileInfo(isFolder) = [];
% Get a cell array of strings.  We don't really use it.  I'm just showing you how to get it in case you want it.
listOfFolderNames = unique({allFileInfo.folder});
numberOfFolders = length(listOfFolderNames);
fprintf('The total number of folders to look in is %d.\n', numberOfFolders);

% Get a cell array of base filename strings.  We don't really use it.  I'm just showing you how to get it in case you want it.
listOfFileNames = {allFileInfo.name};
totalNumberOfFiles = length(listOfFileNames);
fprintf('The total number of files in those %d folders is %d.\n', numberOfFolders, totalNumberOfFiles);

% Process all files in those folders.
totalNumberOfFiles = length(allFileInfo);


for k = 1 : totalNumberOfFiles
        thisFolder = allFileInfo(k).folder;
		thisBaseFileName = allFileInfo(k).name;
		filename = fullfile(thisFolder, thisBaseFileName);
 		fprintf('     Processing file %d of %d : "%s".\n', k, totalNumberOfFiles, filename);
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
end;
