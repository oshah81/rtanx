%% Runs The Experiment (Block 1)

function player_struct = rtanx_experiment_block1(player_struct, w, debug, rootFolder, quitmarker, par)


%% Input data for experiment_data

%  1 = Trial
%  2 = Time
%  3 = Block id
%  4 = Stim 1 p(win)- BLOCK ORDERING FROM INTIALISE
%  5 = Stim 2 p(lose,- BLOCK ORDERING FROM INTIALISE
%  6 = Stimulus (1 = BLUE / 2 = ORANGE)
%  7 = Stimulus position - location on screen (1 = blue LEFT / 2 = blue RIGHT)
%  8 = Player prediction - (Left = 1 VS Right = 0)
%  9 = Reaction time
% 10 = Stimulus Outcome (Orange Win = 0 VS Blue Win = 1)
% 11 = WIN vs LOSE (player outcome) - (Win = 1 / Lose = 0)
% 12 = Prediction time (amount of time allowed to make a choice)
% 13 = ITI Inter trial interval
% 14 = Time for stimulus presenation
% 15 = Time of RESP outcome
% 16 = TAPAS resp Model = (1 = subj picked blue / 0 = subj picked orange)

%%                  Setting up experiment data structure

% Prepare matrix
experiment_data_block1 = nan(player_struct.blocks.n_trial_1, 16); % Empty Matrix NAN
experiment_data_block1(:,1) = 1:player_struct.blocks.n_trial_1; % 1 = Trial number
experiment_data_block1(:,3) = player_struct.blocks.block1_id; % 3 = Block ID

% 4 & 5 = Block ordering of Stim 1 p(win) * Stim 2 p(lose) (from initialise)
for i = 1:player_struct.blocks.n_trial_1
    
    experiment_data_block1(i,4:5) = player_struct.blocks.block1_order(player_struct.blocks.block1_id(i),:);
    
end

% 6 = Stimuli (from initialise)

experiment_data_block1(:,6) = vertcat(player_struct.blocks.stimuli_1{:});

% 7 = Stimulus position

experiment_data_block1(:,7) = vertcat(player_struct.blocks.stimposition_1{:});

% 8 = Block Outcomes Structure (from initialise)

experiment_data_block1(:,10) = vertcat(player_struct.blocks.outcomes_1{:});

% Compile everything into 'player_struct.experiment_data'

player_struct.experiment_data_block1 = experiment_data_block1;

%%                  Setting experimental parameters

%% Set Experimental Parameters

% Times in order

fix_ITI_time = 1.5 + 0.5*rand(1,player_struct.blocks.n_trial_1); % In line with deBerker = 2,000 ms (±500 ms) based on Iglesias et al same
prediction_time = 1.175 + 0.25*rand(1, player_struct.blocks.n_trial_1); % This is deBerker's stimuli presentation 300 ms (±50 ms) + timeout period (prediction time) = 1,000 ms (±200 ms).
display_choice_time = 0.8 + 0.4*rand(1,player_struct.blocks.n_trial_1); % In line with deBerker = prediction was displayed for an averageof 1,200 ms (±200 ms) whihc was based on Iglesias et al fMRI 1sec
display_outcome_time = 1.8 + 0.2*rand(1,player_struct.blocks.n_trial_1); % de berker = Outcomes remained onscreen for 1,000 ms (±200 ms) (but no neuroimaging), Browning et al fixed 2 secs, Iglesias et al was 150ms + ITI = ~2150-2650 ms

%%                        Running the experiment


%% Debugging Trial Length

if debug ==1
    
    n_trial_1 = 5;
    
else
    n_trial_1 = player_struct.blocks.n_trial_1;
end

%%                          Experiment Start

% Tigger Start Exp Block 1


for i_trial = 1 :  n_trial_1
    %% Sets more specific timings for this trial
    
    experiment_data_block1(i_trial,2) = GetSecs(); % Time
    experiment_data_block1(i_trial,12) = prediction_time(i_trial); % Time allowed for the prediction to be made for ntrial
    experiment_data_block1(i_trial,13) = fix_ITI_time(randi(i_trial)); % ITI
    
    %% Time Trial starts
    t1_matlab   = GetSecs();
    %% Fixation Cross Presentation
    
    fixtxt = ['+'];
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    DrawFormattedText(w, fixtxt, 'center', 'center', WhiteIndex(w));
    Screen('Flip',w);
    WaitSecs(experiment_data_block1(i_trial,13)); % fix_time;
    %% Stimulus Presentation
    
    if experiment_data_block1(i_trial,7) == 1    % If position = 1 then present BLUE on LEFT
        % Blue Left
        Screen('PutImage',w, par.images.TB1Frac1,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
        % Orange Right
        Screen('PutImage',w, par.images.TB1Frac2,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        DrawFormattedText(w, fixtxt, 'center', 'center', WhiteIndex(w));
        % Tigger for Stimilus Presentation Blue Left (trigger)
    elseif experiment_data_block1(i_trial,7) == 2 % Elseif position = 2 then draw BLUE on the RIGHT
        % Orange Left
        Screen('PutImage',w, par.images.TB1Frac2,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
        % Blue Right
        Screen('PutImage',w, par.images.TB1Frac1,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        DrawFormattedText(w, fixtxt, 'center', 'center', WhiteIndex(w));
        % Tigger for Stimilus Presentation Blue Right (trigger)
    end
    Screen('Flip',w);
    
    t1 = GetSecs(); % Taking time of each stimulus presentation
    experiment_data_block1(i_trial,14) = t1 - t1_matlab; % Time of stimulus presentation, matlab.
    
    %% Participant Response
    
    % Keys permitted for response
    activeKeys = [par.keys.left par.keys.right par.keys.escapekey par.keys.spacebar];
    % Restrict Key Response
    RestrictKeysForKbCheck(activeKeys);
    
    % Suppress echo to the command line for keypresses
    ListenChar(2);
    
    % repeat until a valid key is pressed or we time out
    timedout = false;
    subj_resp = [];
    while ~timedout
        % Check if a key is pressed
        % Only keys specified in activeKeys are considered valid
        [keyIsDown, keyTime, keyCode] = KbCheck;
        % Respond Left
        if keyCode(par.keys.left) == 1
            subj_resp = 1;
            % Trigger Left Button Press
            break
        end
        % Respond Right
        if keyCode(par.keys.right) == 1
            subj_resp = 2;
            % Tigger Right Button Press
            break
        end
        % If both are pressed
        if isequal([par.keys.left,par.keys.right],keyCode) || isequal([par.keys.right,par.keys.left],keyCode)
            subj_resp = 3;
            % Tigger both Button Press
            break
        end
        % Escape Key
        if keyCode(par.keys.escapekey) == 1
            quitmarker = 1;
            break
        end
        
        % Time out
        if ((keyTime - t1) > experiment_data_block1(i_trial,12))
            timedout = true;
            % Tigger NO response
            break
        end
        
    end
    
    % Reaction time
    if(~timedout)
        experiment_data_block1(i_trial,9) = keyTime - t1; % Reaction Time
    end
    
    % No Response
    if timedout == true
        subj_resp = 4;
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
    end
    
    % Quit the study
    if quitmarker == 1
        ShowCursor;   sca
        return;
    end
    
    % Reset the keyboard input checking for all keys
    RestrictKeysForKbCheck;
    
    % Re-enable echo to the command line for key presses
    % if code crashes before reaching this point
    % CTRL-C will reenable keyboard input
    ListenChar(1)
    
    %% Display Choice
    % Picked LEFT
    
    if subj_resp == 1
        
        % Presents images again (to be outlined by rectangle)
        if experiment_data_block1(i_trial,7) == 1    % If position = 1 then present BLUE on LEFT
            % Blue Left
            Screen('PutImage',w, par.images.TB1Frac1,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Orange Right
            Screen('PutImage',w, par.images.TB1Frac2,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        elseif experiment_data_block1(i_trial,7) == 2 % Elseif position = 2 then draw BLUE on the RIGHT
            % Orange Left
            Screen('PutImage',w, par.images.TB1Frac2,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Blue Right
            Screen('PutImage',w, par.images.TB1Frac1,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        end
        
        % Draws rectangle
        Screen('FrameRect', w, [102, 255, 0],[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778],[3]);
        
        Screen('Flip',w);
        % Player Prediction
        experiment_data_block1(i_trial,8) = subj_resp; % Player prediction; left click = 1, right click = 0
        
        % Picked RIGHT
        
    elseif subj_resp == 2
        
        % Presents images again (to be outlined by rectangle)
        if experiment_data_block1(i_trial,7) == 1    % If position = 1 then present BLUE on LEFT
            % Blue Left
            Screen('PutImage',w, par.images.TB1Frac1,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Orange Right
            Screen('PutImage',w, par.images.TB1Frac2,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        elseif experiment_data_block1(i_trial,7) == 2 % Elseif position = 2 then draw BLUE on the RIGHT
            % Orange Left
            Screen('PutImage',w, par.images.TB1Frac2,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Blue Right
            Screen('PutImage',w, par.images.TB1Frac1,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        end
        
        % Draws rectangle
        Screen('FrameRect', w, [102, 255, 0],[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778],[3]);
        
        Screen('Flip',w);
        % Player Prediction
        experiment_data_block1(i_trial,8) = subj_resp-2; % Player prediction; left click = 1, right click = 0
        
    elseif subj_resp == 3
        
        experiment_data_block1(i_trial,9) = NaN; % reaction time
        experiment_data_block1(i_trial,8) = NaN; % Player prediction no response
        
        blunderpress = ['Please press only 1 button'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, blunderpress, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        
    elseif subj_resp == 4 % No response
        
        experiment_data_block1(i_trial,9) = NaN; % reaction time
        experiment_data_block1(i_trial,8) = NaN; % Player prediction no response
        
        timeout = ['Time Out'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, timeout, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        
    end
    
    %% Wait time before response outcome
    
    WaitSecs(display_choice_time(i_trial));
    
    %% TAPAS Outcome Response and Data Recording
    
    % For Tapas Response Model
    
    if (experiment_data_block1(i_trial,7) == 1) && (experiment_data_block1(i_trial,8) == 1)
        experiment_data_block1(i_trial,16) = 1; % Picked Blue
    elseif (experiment_data_block1(i_trial,7) == 2) && (experiment_data_block1(i_trial,8) == 1)
        experiment_data_block1(i_trial,16) = 0; % Picked Orange
    elseif (experiment_data_block1(i_trial,7) == 1) && (experiment_data_block1(i_trial,8) == 0)
        experiment_data_block1(i_trial,16) = 0; % Picked Orange
    elseif (experiment_data_block1(i_trial,7) == 2) && (experiment_data_block1(i_trial,8) == 0)
        experiment_data_block1(i_trial,16) = 1; % Picked Blue
    else
        experiment_data_block1(i_trial,16) = NaN;
    end
    
    %% Trial Outcome
    
    %   ****************************** This below is for wins **************************************
    
    %   Potential Win vs Lose BLUE             BLUE POSITION L/R                    P_RESP
    if (experiment_data_block1(i_trial,10) == 1) && (experiment_data_block1(i_trial,7) == 1)  && (experiment_data_block1(i_trial,8) == 1)
        
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 1;
        
        % Trigger Win
        
        
    elseif (experiment_data_block1(i_trial,10) == 1) && (experiment_data_block1(i_trial,7) == 2)  && (experiment_data_block1(i_trial,8) == 0);
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 1;
        
        % Trigger Win
        
        
    elseif (experiment_data_block1(i_trial,10) == 0) && (experiment_data_block1(i_trial,7) == 1)  && (experiment_data_block1(i_trial,8) == 0);
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 1;
        
        % Trigger Win
        
        
    elseif (experiment_data_block1(i_trial,10) == 0) && (experiment_data_block1(i_trial,7) == 2)  && (experiment_data_block1(i_trial,8) == 1);
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 1;
        
        % Trigger Win
        
        
        %   ****************************** This below is for lose response **************************************
        
        %10=Stimulus Outcome(OrangeWin=0 VS BlueWin=1)  7 = (1=blueLEFT/2=blueRIGHT)        8 = PlayerPrediction(Left=1 VS Right=0)
        
    elseif (experiment_data_block1(i_trial,10) == 1) && (experiment_data_block1(i_trial,7) == 1)  && (experiment_data_block1(i_trial,8) == 0);
        
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 0;
        
        % Trigger Lose
        
    elseif (experiment_data_block1(i_trial,10) == 1) && (experiment_data_block1(i_trial,7) == 2)  && (experiment_data_block1(i_trial,8) == 1);
        
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 0;
        
        
    elseif (experiment_data_block1(i_trial,10) == 0) && (experiment_data_block1(i_trial,7) == 1)  && (experiment_data_block1(i_trial,8) == 1);
        
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 0;
        
        
    elseif (experiment_data_block1(i_trial,10) == 0) && (experiment_data_block1(i_trial,7) == 2)  && (experiment_data_block1(i_trial,8) == 0);
        
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = 0;
        
        %   ****************************** This below is for no response **************************************
        
        
    else
        experiment_data_block1(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        noresptxt = ['No response! 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, noresptxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        experiment_data_block1(i_trial,11) = NaN;
        
        % Trigger No Resp
        
        
    end
    
    %% Wait time after display outcome
    WaitSecs(display_outcome_time(i_trial));
    
    %% Data Save
    player_struct.experiment_data_block1 = experiment_data_block1;
    save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');
end

end

