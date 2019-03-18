function [ang] = constr_ang(angHeader,Data,Ini)
fprintf(1,'\n\nang-file construction');                                     % Screen Output
fprintf(1,'\n...........................................................'); % Screen Output
ang = angHeader.Stage;

%Read in and write phase headers
[Ini.PhaseNrs,temp.ind]=sort(Ini.PhaseNrs);                                 % Sort Order of Phases
Ini.PhaseNames = Ini.PhaseNames(temp.ind);                                  % Sort Names of Phases accordingly

for i = 1:size(Ini.PhaseNrs,2) 
    fprintf('\n\t->\tPhase %i: %s',Ini.PhaseNrs(i),Ini.PhaseNames{i});      % Screen output
    temp.name = [Ini.path,'\data\PhaseHeaders\',Ini.PhaseNames{i},'.txt'];  % Assemble phase name
    temp.phase = read_phase(temp.name);                                     % Read in Phase header
    temp.phase{1} = ['# Phase ',num2str(Ini.PhaseNrs(i))];                  % Update Phase Nr
    ang = {ang{:},temp.phase{:}};                                           % Append Phase header to ang file
end

%Append Grid
angHeader.Grid{2} = [angHeader.Grid{2},num2str(Ini.xstep)];                 % Write x step
angHeader.Grid{3} = [angHeader.Grid{3},num2str(Ini.ystep)];                 % Write y step
angHeader.Grid{6} = [angHeader.Grid{6},num2str(Ini.nrRows)];                % Write Nr of rows
ang = {ang{:},angHeader.Grid{:}};                                           % Append Grid Info

%Append General Info
ang = {ang{:},angHeader.General{:}};                                        % Append General Info

%Write new coordinates
temp.x = linspace(0,(Ini.nrCols-1)*Ini.xstep,Ini.nrCols);                   % Compute X coordinates
temp.y = linspace(0,(Ini.nrRows-1)*Ini.ystep,Ini.nrRows);                   % Compute X coordinates
Data.X = repmat(temp.x,1,Ini.nrRows)';                                      % Compute new X vector
Data.Y = repelem(temp.y,Ini.nrCols)';                                       % Compute new Y vector

%Correct length of new coordinates
if size(Data.X,1)-size(Data.Phase,1) || size(Data.Y,1)-size(Data.Phase,1)
    Data.X(size(Data.X,1) + (size(Data.Phase,1)-size(Data.X,1)+1) : size(Data.X,1)) = [];
    Data.Y(size(Data.Y,1) - (size(Data.Phase,1)-size(Data.Y,1)+1) : size(Data.Y,1)) = [];
end

clear tmp i

%Sort data and write ang file
ang_dat = [Data.Euler1,Data.Euler2,Data.Euler3,Data.X,Data.Y,Data.BC,...
           Data.BS./ max(Data.BS),Data.Phase, ones(size(Data.X)),Data.MAD]; % Sorting Columns: [Euler1,Euler2,Euler3,X,Y,IQ,CI,phase,Edge,FIT] 
Ini.ang_filename = [Ini.path,'\',Ini.OutDir,'\',Ini.name,'.ang'];           % Full filename with path
fprintf(1,'\n\t->\tBusy writing data ...');                                 % Screen Output
dlmcell(Ini.ang_filename,ang');                                             % Write ang-header into ang file
dlmwrite(Ini.ang_filename,ang_dat,'-append','precision',4,'delimiter',...
         '\t','newline', 'pc');                                             % Append ang data to ang file
fprintf(1,'\n\t->\tang file created and saved under %s',Ini.ang_filename);  % Screen Output
fprintf(1,'\n...........................................................'); % Screen Output