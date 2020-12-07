function rtanx_run(ID)

% Thomas Hein 04/01/2020 - rtanx - binary reward learning task

% *** Updated for use with psychtoolbox

%% Directory
rootFolder = 'F:\MATLAB_Scripts\Russia\tanx_psychtoolbox';
cd (rootFolder);

% Add Functions
addpath([rootFolder '\Functions\']);
addpath([rootFolder '\Images\']);
addpath([rootFolder '\Data\']);

%%  Initialise Random Seed
try
    rng('shuffle'); % initialise random number generator with random seed
catch
    rand('seed',100*sum(clock));
end

%% Player Structure

player_struct.filename = ID;
player_struct.initials = lower(input('Participant initials? ','s'));
debug = strcmp(player_struct.initials,'debug') == 1;

if debug ==1
    player_struct.id = 'debug';
    player_struct.dob = '04/01/1987';
    player_struct.sex = 'm';
else
    player_struct.dob = input('Date of birth (dd/mm/yyyy)? ','s');
    player_struct.sex = input('Sex (m/f)? ','s');
    player_struct.id = [player_struct.filename];
end

player_struct.date = datestr(date,'dd/mm/yy');
player_struct.task_version = 'rtanx_';

% Dir for saving
if ~exist([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id)],'dir')
    mkdir([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id)]);
end

%% Initialise Task Settings
% Probabilistic Mappings, Timings, par (keyboard, colours)

[blocks, par] = rtanx_initialise;
player_struct.blocks = blocks;
clear blocks;
% Save
save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');

%% Psychtoolbox Configuration/Initialisation

% Set screen settings
Screen('Preference', 'VisualDebuglevel', 3);        % replace the psychtoolbox startup screen with a black display.
Screen('Preference', 'VBLTimestampingMode', 4);     % this helps on windows machines; cf. help BeampositionQueries
Screen('Preference', 'SkipSyncTests', 0);           % force Psychtoolbox to continue, despite the syncronization error ('PTB - ERROR: SYNCHRONIZATION FAILURE'). Only in Mac. Remember to remove this when actually testing!
screens = Screen('Screens');                        % Choosing the display with the highest display number to get the current display.
screenNumber = max(screens);
black = BlackIndex(screenNumber);
[w, windowRect] = PsychImaging('OpenWindow',screenNumber, black); % [0,0,500,500] // maybe replace with just Screen('OpenWindow etc

% Saving screen coordinates
[par.monitor.screenXpixels, par.monitor.screenYpixels] = Screen('WindowSize', w, []);
[par.monitor.xCent, par.monitor.yCent] = RectCenter(windowRect);
par.monitor.imgCentL = [par.monitor.xCent/2, par.monitor.yCent];
par.monitor.imgCentR = [par.monitor.xCent/2*3, par.monitor.yCent];

% Hide the mouse cursor:
HideCursor;

% Inter-flip interval
ifi = Screen('GetFlipInterval', w);
if ifi>.02
    disp(num2str(ifi))
    disp('timing error')
    sca
    keyboard % get to the debugger mode
end

quitmarker = 0;
%%   Task instruction scripts

% Start time of experiment
player_struct.chrono.session_start = datestr(now,'HH:MM');

% Task instructions
rtanx_task_instructions;
% Test of reward outcome
rtanx_task_instructions_test;
% Task instructions about probability
rtanx_task_instructions_2;
% Test about probability
rtanx_task_instructions_2_test;
% Final instructions before practice
rtanx_pre_practice_instructions;

%% Practice
% Records time before practice
player_struct.chrono.practice_start = datestr(now,'HH:MM');

% Calls practice instructions function.
player_struct = rtanx_practice(player_struct, w, quitmarker, par);

% Calls practice experiment function.
player_struct = rtanx_practice_experiment(player_struct, w, debug, rootFolder, quitmarker, par);

% Records time after completion.
player_struct.chrono.practice_end = datestr(now,'HH:MM'); % / (1000 * 60);

% Saves practice data
save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');

%% Instructions prior to experiment

rtanx_pre_task_instructions;

%% 3. Experiment (Block 1)

% Take Time
player_struct.chrono.experiment_block1_start = datestr(now,'HH:MM');

% Run Block 1
player_struct = rtanx_experiment_block1(player_struct, w, debug, rootFolder, quitmarker, par);

% Take Time
player_struct.chrono.experiment_block1_end = datestr(now,'HH:MM');

% Save
save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');
%% Break

rtanx_break;

%% 4. Experiment (Block 2)

% Take Time
player_struct.chrono.experiment_block2_start = datestr(now,'HH:MM');

% Run Block 2
player_struct = rtanx_experiment_block2(player_struct, w, debug, rootFolder, quitmarker, par);

% Take Time
player_struct.chrono.experiment_block2_end = datestr(now,'HH:MM');

% Save
save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');

%% End Experiment

rtanx_final_slide;

tmp = fix(clock);
player_struct.chrono.session_end = [num2str(tmp(4)),'.',num2str(tmp(5)),':',num2str(tmp(6))];
save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');

sca;

%% Final

% Experiment Coding Key input to player_struct
rtanx_experimental_coding_key;

% Final Save
save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');
end

