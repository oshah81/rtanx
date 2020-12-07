%%  rtanx_task_instructions_test

% This tests if the participant was paying attention to how much they earn
% for each correct prediction.


%% Test

testtxt1 = ['How much are you rewarded for \n\n'...
    'getting a prediction right? \n\n'...
    ' \n\n'...
    '(1) 1 p  (2) 0 p  (3) 5 p  (4) 2 p  \n\n'...
    ' \n\n'...
    'Use the keyboard to enter your answer (choose 1, 2, 3, or 4)'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, testtxt1,'center', 'center', WhiteIndex(w));
Screen('Flip',w);

% Wait for response
test_answer = 0;
while KbCheck; end
success = 0;
while success == 0
    pressed = 0;
    while pressed == 0; [pressed,~, kbData] = KbCheck;  end
    
    if kbData(par.keys.three) == 1
        test_answer = 1;
        break;
    elseif kbData(par.keys.one) == 1
        break;
    elseif kbData(par.keys.two) == 1
        break;
    elseif kbData(par.keys.four) == 1
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
    Correct = ['Correct! Bravo, let''s move on'];
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    Screen(w,'TextStyle',0);  % define font style to normal.
    Screen(w,'FillRect',[0 0 0]); % Set background colour to black
    DrawFormattedText(w, Correct,'center', 'center', [102, 255, 0], 90);
    Screen(w,'Flip'); % Update the display to show the text on-line.
    WaitSecs(1.5);
elseif test_answer == 0
    Incorrect = ['Incorrect. Unlucky, try again'];
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    Screen(w,'TextStyle',0);  % define font style to normal.
    Screen(w,'FillRect',[0 0 0]); % Set background colour to black
    DrawFormattedText(w, Incorrect,'center', 'center', par.col.tpred);
    Screen(w,'Flip'); % Update the display to show the text on-line.
    WaitSecs(1.5);
    rtanx_task_instructions_test; % Calls function to repeat if incorrect.
end
