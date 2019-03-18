function [Ini] = extract_ctf(Ini,ctf)

fprintf(1,'\n\nData Extraction');                                           % Screen Output
fprintf(1,'\n...........................................................'); % Screen Output
%xstep
temp.xstep = ctf{7};                                                        % Extract xstep string
temp.xstep = strrep(temp.xstep,',','.');                                    % Eventually replace comma by dot
temp.xstep = str2double(temp.xstep(7:end));                                 % Extract xstep numeric value
Ini.xstep = round(temp.xstep/Ini.stepround)*Ini.stepround;                  % Round xstep value
fprintf('\n\t->\txstep %.5f round to %.5f',temp.xstep,Ini.xstep);           % Screen output
%ystep
temp.ystep = ctf{8};                                                        % Extract xstep string
temp.ystep = strrep(temp.ystep,',','.');                                    % Eventually replace comma by dot
temp.ystep = str2double(temp.ystep(7:end));                                 % Extract xstep numeric value
Ini.ystep = round(temp.ystep/Ini.stepround)*Ini.stepround;                  % Round xstep value
fprintf('\n\t->\tystep %.5f round to %.5f',temp.ystep,Ini.ystep);           % Screen output
%Nr of rows
temp.nrrows = ctf{6};                                                       % Extract nr of Rows string
Ini.nrRows = str2double(temp.nrrows(7:end));                                % Extract nr of Rows
%Nr of columns
temp.nrcols = ctf{5};                                                       % Extract nr of Columns string
Ini.nrCols = str2double(temp.nrcols(7:end));                                % Extract nr of Columns