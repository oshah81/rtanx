%% rtanx_pre_task_instructions

%% Page 1

% Example of images used

% Textcgtext('Good. You should now be familiar with how the experiment works',0,250);

inst3txt = ['Excellent! Now you should be familiar with the task. \n\n '...
    '\n\n '...
    'To recap: you will be shown a series of images \n\n '...
    'and you need to predict which one is more rewarding. \n\n '...
    '\n\n '...
    'For each correct prediction you will earn 5p; for each incorrect it''s 0p \n\n '...
    'Make your predictions quickly, otherwise the trial will time out and you get 0p! \n\n '...
    '\n\n '...
    'Ok, now we will move on to the task ...'];


psbt = ['Press space bar when ready to start'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, inst3txt,'center', par.monitor.screenYpixels/4, WhiteIndex(w)); % par.monitor.screenYpixels/4
DrawFormattedText(w, psbt,'center', par.monitor.screenYpixels - par.monitor.screenYpixels/10,  par.col.tpred); %[0.5882,0,0.2]); % par.col.tpred
Screen('Flip',w);

% Wait for response

test_answer = 0;
while KbCheck; end
success = 0;
while success == 0
    pressed = 0;
    while pressed == 0; [pressed,~, kbData] = KbCheck;  end
    
    if kbData(par.keys.spacebar) == 1
        test_answer = 1;
        break;
    end
    if kbData(par.keys.escapekey)==1
        quitmarker = 1;
        break;
    end
end

% Quit the study
if quitmarker == 1
    ShowCursor;   sca
    return;
end

% Test Outcome Display

if test_answer == 1
    
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    Screen(w,'TextStyle',0);  % define font style to normal.
    Screen(w,'FillRect',[0 0 0]); % Set background colour to black
    
    oktxt_1 = ['Ok, let''s begin .'];
    DrawFormattedText(w, oktxt_1,'center', 'center', WhiteIndex(w));
    Screen('Flip',w);
    WaitSecs(0.7);
    
    oktxt_2 = ['Ok, let''s begin ..'];
    DrawFormattedText(w, oktxt_2,'center', 'center', WhiteIndex(w));
    Screen('Flip',w);
    WaitSecs(0.7);
    
    oktxt_3 = ['Ok, let''s begin ...'];
    DrawFormattedText(w, oktxt_3,'center', 'center', WhiteIndex(w));
    Screen('Flip',w);
    WaitSecs(0.7);
end



