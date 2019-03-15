function [Ini] = get_files(Ini)
   Ini.allFiles = dir(Ini.path);
   Ini.allFiles = {Ini.allFiles(:).name};
   Ini.FileInd = strfind(Ini.allFiles,'.ctf');
   Ini.FileInd = find(not(cellfun('isempty', Ini.FileInd)));
   Ini.allFiles = Ini.allFiles(Ini.FileInd);
   Ini.allFiles = regexprep(Ini.allFiles,'.ctf','');