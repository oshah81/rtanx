%%  rtanx_task_instructions_test2

% This tests if the participant understands the probabilities are reciprocal

%% Test

test2txt1 = ['If you can sense the probability of reward for one image, \n\n '...
                'you can understand the probability of reward for the other. \n\n '...
                ' \n\n '...
                'If the probability of the blue image rewarding you is 60% \n\n '...
                'what is the probability of the orange image rewarding you?'];

% [~, par.monitor.screenYpixels] = Screen('WindowSize', w, []);
Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, test2txt1,'center', par.monitor.screenYpixels/4 - par.monitor.screenYpixels*0.1574, WhiteIndex(w));% 100

probtesttxt_blue = ['Blue rewards 60% of time'];
probtesttxt_orange = ['Orange image rewards?'];

% Image
Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent - par.monitor.xCent*0.5209, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065, par.monitor.xCent - par.monitor.xCent*0.5209+400, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065+400]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent + par.monitor.xCent*0.1042, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065, par.monitor.xCent + par.monitor.xCent*0.1042+400, par.monitor.screenYpixels - par.monitor.screenYpixels*0.2361]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue

DrawFormattedText(w, probtesttxt_blue, par.monitor.xCent - par.monitor.xCent*0.52, par.monitor.screenYpixels - par.monitor.screenYpixels*0.21, WhiteIndex(w));
DrawFormattedText(w, probtesttxt_orange, par.monitor.xCent + par.monitor.xCent*0.125, par.monitor.screenYpixels - par.monitor.screenYpixels*0.21, WhiteIndex(w));


choosetext1 = ['Use the keyboard to choose  \n\n '...
                    '(1) 60% (2) 40% (3) 20% (4) 10% '];

DrawFormattedText(w, choosetext1, 'center', par.monitor.screenYpixels - par.monitor.screenYpixels*0.12035, WhiteIndex(w)); % 950 [ par.monitor.screenYpixels-130 ]

Screen('Flip',w);

% Wait for response
test_answer = 0;
while KbCheck; end
success = 0;
while success == 0
    pressed = 0;
    while pressed == 0; [pressed,~, kbData] = KbCheck;  end
    
    if kbData(par.keys.two) == 1
        test_answer = 1;
        break;
    elseif kbData(par.keys.one) == 1
        break;
    elseif kbData(par.keys.three) == 1
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
%     [~, par.monitor.screenYpixels] = Screen('WindowSize', w, []);
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    Screen(w,'TextStyle',0);  % define font style to normal.
    Screen(w,'FillRect',[0 0 0]); % Set background colour to black
    DrawFormattedText(w, Correct,'center', 'center', [102, 255, 0], 90);
    Screen(w,'Flip'); % Update the display to show the text on-line.
    WaitSecs(1.5);
elseif test_answer == 0
    Incorrect = ['Incorrect. Unlucky, try again'];
%     [~, par.monitor.screenYpixels] = Screen('WindowSize', w, []);
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    Screen(w,'TextStyle',0);  % define font style to normal.
    Screen(w,'FillRect',[0 0 0]); % Set background colour to black
    DrawFormattedText(w, Incorrect,'center', 'center', par.col.tpred);
    Screen(w,'Flip'); % Update the display to show the text on-line.
    WaitSecs(1.5);
    rtanx_task_instructions_2_test; % Calls function to repeat if incorrect.
end

