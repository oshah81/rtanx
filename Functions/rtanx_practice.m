% Practice Instructions

function player_struct = rtanx_practice(player_struct, w, quitmarker, par)

    
practxt = ['Now you will try some practice trials. \n\n'...
            'The wins or losses during practice will not count toward your final score. \n\n'...
            '\n\n'...
            'Please use the arrow keys to choose between images. \n\n'...
            '\n\n'...
            '\n\n'...
            'To pick the image on the LEFT of the screen use the left arrow key \n\n'...
            'To pick the image on the RIGHT of the screen use the right arrow key'];
            
psbt = ['Press space bar to start'];

% [~, par.monitor.screenYpixels] = Screen('WindowSize', w, []);
Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, practxt,'center', par.monitor.screenYpixels/4, WhiteIndex(w)); % par.monitor.screenYpixels/4
DrawFormattedText(w, psbt,'center', par.monitor.screenYpixels - par.monitor.screenYpixels*0.1,  par.col.tpred); %[0.5882,0,0.2]); % par.col.tpred
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

end
