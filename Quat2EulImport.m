  quatMat = [wnumber xnumber ynumber znumber];
  eulZYZ = quat2eul(quatMat,'ZYZ');
  rotm = quat2rotm(quatMat);

  filename = 'C:\Users\Amira\Documents\Capstone\MATLAB PROJECT\output.xlsx'; % change path here!
  headers = {'First (?)','Second (?)','Third (?)'};
  xlswrite(filename,[headers; num2cell(eulZYZ)]);

