%main.m
% Main file to 'ctf2ang' - Conversion of ctf to ang 
% -> Tested for Bruker to TSL
% *************************************************************************
% Dr. Frank Niessen, University of Wollongong, Australia, 2019
% contactnospam@fniessen.com (remove the nospam to make this email address 
% work)
% *************************************************************************
% ang column names: [Euler1,Euler2,Euler3,X,Y,IQ,CI,phase,Edge,FIT]
% ang IQ is equivalent to 'ctf' BC
% ang CI can be approximated by 'ctf' BS
% Edge is not important - set to 1
% ang FIT is equivalent to ctf MAD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User Instructions:
% Indicate path and name of your ctf file below by assingment to variables
% 'Ini.path' and 'Ini.Name', respectively. All ctf-files in a path can be
% converted by setting 'Ini.name' to '*'.
% State the names and index numbers of the investigated phases by
% assignment to variables 'Ini.PhaseNames' and 'Ini.PhaseNrs',
% respectively. The phase-names can be chosen arbitrarily, but have to correspond
% to a name of a phase file in the folder 'PhaseFiles'. Phase Files are 
% created by copying the phase-header from an
% existing ang-file and saving it as a txt-file in the 'PhaseFiles'
% folder.
% 'Ini.stepround' is used to specify to which degree the x and y stepsize
% should be rounded. Please see the screen output during execution to check
% the degree of rounding.

clear
clc 
close all

fprintf(1,'--------------------------------------------------------------\n');
fprintf(1,'ctf2ang - Fileconversion - (c) Frank Niessen DTU 05/2016\n');
fprintf(1,'--------------------------------------------------------------\n\n');

%% USER INPUT - declaration
Ini.path = fileparts(mfilename('fullpath'));                                % Filepath
Ini.name = 'test';                                                          % Filename [Set to '*' for all files in path]
Ini.InDir = 'data\Input - ctf';                                             % Input subdirectory
Ini.OutDir = 'data\Output - ang';                                           % Input subdirectory
Ini.PhaseNames = {'Austenite','Ferrite'};                                   % List of phases - Headerfiles of phases have to be saved in subfolder 'phases' and listed in ctf file
Ini.PhaseNrs =   [1 2];                                                     % Corresponding PhaseNrs
Ini.stepround = 1e-3;                                                       % Rounding dimension of stepsize

%% Initialization
Ini.ang_varname = 'angHeader';                                              % Name of header variable
load(Ini.ang_varname);                                                      % Read in ang-header 
if strcmp(Ini.name,'*')
   [Ini] = get_files(Ini);                                                  % Find file names
else
    Ini.allFiles = {Ini.name};
end

%% Data extraction and file conversion
for i = 1:length(Ini.allFiles)
    fprintf(1,'\nFile %i of %i \n',i,length(Ini.allFiles));
    fprintf(1,'--------------------------------------------------------------');
    Ini.name = Ini.allFiles{i};                                             % Read in Filename
    [Ini,ctf,Data] = ini(Ini);                                              % Execute Function 'ini.m'          - Reading in Data  
    [Ini] = extract_ctf(Ini,ctf);                                           % Execute Function 'extract_ctf.m'  - Extracting specific Data from ctf header 
    ang = constr_ang(angHeader,Data,Ini);                                   % Execute Function 'constr_ang.m'   - Construction of ang file
end
fprintf(1,'\nctf2ang terminated!\n\n'); % Screen Output