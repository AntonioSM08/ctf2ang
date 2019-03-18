function [Ini,ctf,Data] = ini(Ini)
Ini.fullname = [Ini.path,'\',Ini.InDir,'\',Ini.name,'.ctf'];                % Full filename with path
ctf = read_ctf_header(Ini.fullname);                                        % Read in header of ctf file   
Data = read_ctf_data(Ini.fullname);                                         % Read in data of ctf file


fprintf(1,'\n\nInitialization');                                            % Screen Output
fprintf(1,'\n...........................................................'); % Screen Output
fprintf(1,'\n\t->\tConversion of file %s',Ini.fullname);                    % Screen Output