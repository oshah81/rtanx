%%      Practice Experiment

function player_struct = rtanx_practice_experiment(player_struct, w, debug, rootFolder, quitmarker, par)


%% Preparing Data Matrix

% Prepare Data Matrix
practice_data = nan(player_struct.blocks.prac_n_trial_1, 16);
% Trial NMumber
practice_data(:,1) = 1:player_struct.blocks.prac_n_trial_1;
% Block ID
practice_data(:,3) = player_struct.blocks.prac_block1_id;

n_trial = player_struct.blocks.prac_n_trial_1;

for i = 1:n_trial
    practice_data(i,4:5) = player_struct.blocks.prac_order(player_struct.blocks.prac_block1_id(i),:);
end

practice_data(:,6) = vertcat(player_struct.blocks.prac_stimuli_1{:});
practice_data(:,10) = vertcat(player_struct.blocks.prac_outcomes_1{:});
practice_data(:,7) = vertcat(player_struct.blocks.prac_stimposition_1{:});
%% Practice specific bit

tmp = vertcat(practice_data(practice_data(:,3) == 5,:),practice_data(practice_data(:,3) == 7,:));

if tmp(1,4) == tmp(end,4) % both blocks are the same;
    tmp = vertcat(practice_data(practice_data(:,3) == 5,:),practice_data(practice_data(:,3) == 8,:));
end

tmp = tmp(1:2:length(tmp),:);

practice_data = tmp;
player_struct.practice_data = tmp;

n_trial = length(tmp);
clear tmp

%% Set Experimental Parameters

% Times in order

fix_ITI_time = 1.5 + 0.5*rand(1,player_struct.blocks.prac_n_trial_1); % In line with deBerker = 2,000 ms (±500 ms) based on Iglesias et al same
prediction_time = 1.175 + 0.25*rand(1, player_struct.blocks.prac_n_trial_1); % This is deBerker's stimuli presentation 300 ms (±50 ms) + timeout period (prediction time) = 1,000 ms (±200 ms).
display_choice_time = 0.8 + 0.4*rand(1,player_struct.blocks.prac_n_trial_1); % In line with deBerker = prediction was displayed for an averageof 1,200 ms (±200 ms) whihc was based on Iglesias et al fMRI 1sec
display_outcome_time = 1.8 + 0.2*rand(1,player_struct.blocks.prac_n_trial_1); % de berker = Outcomes remained onscreen for 1,000 ms (±200 ms) (but no neuroimaging), Browning et al fixed 2 secs, Iglesias et al was 150ms + ITI = ~2150-2650 ms



%%                          Experiment Start


if debug ==1
    n_trial = 5;
else
    n_trial = 10;
end


% Tigger Start Practice

for i_trial = 1 :  n_trial
    
    %% Specific timings for this trial
    
    practice_data(i_trial,2) = GetSecs(); % Time
    practice_data(i_trial,12) = prediction_time(i_trial); % Time allowed for the prediction to be made for this trial
    practice_data(i_trial,13) = fix_ITI_time(randi(i_trial)); % This was 17
    
    
    %% Experimental Data Structure
    
    % new version
    
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
    % 14 = Time of STIMULUS presenation
    % 15 = Time of OUTCOME presentation
    % 16 = TAPAS resp Model = (1 = subj picked blue / 2 = subj picked orange)
    
    
    %% Time Trial starts
    t1_matlab   = GetSecs();
    %% Fixation Cross Presentation
    
    fixtxt = ['+'];
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    DrawFormattedText(w, fixtxt, 'center', 'center', WhiteIndex(w));
    Screen('Flip',w);
    % Wait time for Fixation Cross
    WaitSecs(practice_data(i_trial,13)); % fix_ITI_time
    
    %% Stimulus Presentation
    
    if practice_data(i_trial,7) == 1    % If position = 1 then present BLUE on LEFT
        % Blue Left
        Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
        % Orange Right
        Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        DrawFormattedText(w, fixtxt, 'center', 'center', WhiteIndex(w));
        % Tigger for Stimilus Presentation Blue Left (trigger)
    elseif practice_data(i_trial,7) == 2 % Elseif position = 2 then draw BLUE on the RIGHT
        % Orange Left
        Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
        % Blue Right
        Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        DrawFormattedText(w, fixtxt, 'center', 'center', WhiteIndex(w));
        % Tigger for Stimilus Presentation Blue Right (trigger)
    end
    Screen('Flip',w);
    
    t1 = GetSecs(); % Taking time of each stimulus presentation
    practice_data(i_trial,14) = t1 - t1_matlab; % Time of stimulus presentation, matlab.
    
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
        if ((keyTime - t1) > practice_data(i_trial,12))
            timedout = true;
            % Tigger NO response
            break
        end
        
    end
    
    % Reaction time
    if(~timedout)
        practice_data(i_trial,9) = keyTime - t1; % Reaction Time
    end
    
    % No Response
    if timedout == true
        subj_resp = 4;
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
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
    
    % Time
    t2 = GetSecs();
    
    %% Display Choice
    
    % Picked LEFT
    
    if subj_resp == 1
        
        % Presents images again (to be outlined by rectangle)
        if practice_data(i_trial,7) == 1    % If position = 1 then present BLUE on LEFT
            % Blue Left
            Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Orange Right
            Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        elseif practice_data(i_trial,7) == 2 % Elseif position = 2 then draw BLUE on the RIGHT
            % Orange Left
            Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Blue Right
            Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        end
        
        % Draws rectangle
        Screen('FrameRect', w, [102, 255, 0],[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778],[3]);
        
        Screen('Flip',w);
        % Player Prediction
        practice_data(i_trial,8) = subj_resp; % Player prediction; left click = 1, right click = 0
        
        % Picked RIGHT
        
    elseif subj_resp == 2
        
        % Presents images again (to be outlined by rectangle)
        if practice_data(i_trial,7) == 1    % If position = 1 then present BLUE on LEFT
            % Blue Left
            Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Orange Right
            Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        elseif practice_data(i_trial,7) == 2 % Elseif position = 2 then draw BLUE on the RIGHT
            % Orange Left
            Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent-par.monitor.xCent*0.5208, par.monitor.yCent-par.monitor.yCent*0.2778, par.monitor.xCent-par.monitor.xCent*0.2083, par.monitor.yCent+par.monitor.yCent*0.2778]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
            % Blue Right
            Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
        end
        
        % Draws rectangle
        Screen('FrameRect', w, [102, 255, 0],[par.monitor.xCent+par.monitor.xCent*0.2083, par.monitor.yCent-par.monitor.yCent*0.2778 , par.monitor.xCent+par.monitor.xCent*0.5208, par.monitor.yCent+ par.monitor.yCent*0.2778],[3]);
        
        Screen('Flip',w);
        % Player Prediction
        practice_data(i_trial,8) = subj_resp-2; % Player prediction; left click = 1, right click = 0
        
    elseif subj_resp == 3
        
        practice_data(i_trial,9) = NaN; % reaction time
        practice_data(i_trial,8) = NaN; % Player prediction no response
        
        blunderpress = ['Please press only 1 button'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, blunderpress, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        
    elseif subj_resp == 4 % No response
        
        practice_data(i_trial,9) = NaN; % reaction time
        practice_data(i_trial,8) = NaN; % Player prediction no response
        
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
    
    if (practice_data(i_trial,7) == 1) && (practice_data(i_trial,8) == 1)
        practice_data(i_trial,16) = 1;
    elseif (practice_data(i_trial,7) == 2) && (practice_data(i_trial,8) == 1)
        practice_data(i_trial,16) = 0;
    elseif (practice_data(i_trial,7) == 1) && (practice_data(i_trial,8) == 0)
        practice_data(i_trial,16) = 0;
    elseif (practice_data(i_trial,7) == 2) && (practice_data(i_trial,8) == 0)
        practice_data(i_trial,16) = 1;
    else
        practice_data(i_trial,16) = NaN;
    end
    
    %% Trial Outcome
    
    %   ****************************** This below is for wins **************************************
    
    %   Potential Win vs Lose BLUE             BLUE POSITION L/R                    P_RESP
    if (practice_data(i_trial,10) == 1) && (practice_data(i_trial,7) == 1)  && (practice_data(i_trial,8) == 1)
        
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 1;
        
        % Trigger Win
        
        
    elseif (practice_data(i_trial,10) == 1) && (practice_data(i_trial,7) == 2)  && (practice_data(i_trial,8) == 0);
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 1;
        
        % Trigger Win
        
    elseif (practice_data(i_trial,10) == 0) && (practice_data(i_trial,7) == 1)  && (practice_data(i_trial,8) == 0);
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 1;
        
        % Trigger Win
        
        
    elseif (practice_data(i_trial,10) == 0) && (practice_data(i_trial,7) == 2)  && (practice_data(i_trial,8) == 1);
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        wintxt = ['Win! +3p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, wintxt, 'center', 'center', [102, 255, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 1;
        
        % Trigger Win
        
        
        %   ****************************** This below is for lose response **************************************
        
        %10=Stimulus Outcome(OrangeWin=0 VS BlueWin=1)  7 = (1=blueLEFT/2=blueRIGHT)        8 = PlayerPrediction(Left=1 VS Right=0)
        
    elseif (practice_data(i_trial,10) == 1) && (practice_data(i_trial,7) == 1)  && (practice_data(i_trial,8) == 0);
        
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 0;
        
        % Trigger Lose
        
    elseif (practice_data(i_trial,10) == 1) && (practice_data(i_trial,7) == 2)  && (practice_data(i_trial,8) == 1);
        
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 0;
        
        
    elseif (practice_data(i_trial,10) == 0) && (practice_data(i_trial,7) == 1)  && (practice_data(i_trial,8) == 1);
        
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 0;
        
        
    elseif (practice_data(i_trial,10) == 0) && (practice_data(i_trial,7) == 2)  && (practice_data(i_trial,8) == 0);
        
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        losetxt = ['Lose 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, losetxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = 0;
        
        %   ****************************** This below is for no response **************************************
        
        
    else
        practice_data(i_trial,15) = GetSecs - t1_matlab; % time of outcome, matlab
        noresptxt = ['No response! 0p'];
        Screen('TextSize', w, par.txtsize);
        Screen('TextFont', w, 'Arial');
        DrawFormattedText(w, noresptxt, 'center', 'center', [255, 0, 0]);
        Screen('Flip',w);
        % Money Counter
        practice_data(i_trial,11) = NaN;
        
        % Trigger No Resp
        
        
    end
    
    %% Wait time after display outcome
    WaitSecs(display_outcome_time(i_trial));
    
    %% Save
    player_struct.practice_data = practice_data;
    save ([rootFolder '\Data\'  player_struct.task_version num2str(player_struct.id) '\' player_struct.task_version num2str(player_struct.id) '.mat'],'player_struct');
end

end
