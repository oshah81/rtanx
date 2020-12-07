
%% rtanx_break Break


%% Page 1

break1txt = ['Please stop and take a short break.'];
psbt = ['Press space bar to continue'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, break1txt,'center',  'center', WhiteIndex(w)); % So here y = 270
DrawFormattedText(w, psbt,'center', par.monitor.screenYpixels - par.monitor.screenYpixels/10,  par.col.tpred); %[0.5882,0,0.2]); % par.col.tpred
Screen('Flip',w);

% Wait for response

while KbCheck; end
success = 0;
while success == 0
    pressed = 0;
    while pressed == 0; [pressed,~, kbData] = KbCheck;  end
    if kbData(par.keys.spacebar) == 1
        break;
    end
    
    if kbData(par.keys.escapekey)==1
        quitmarker = 1;
        break;
    end
end
% quit the study
if quitmarker == 1
    ShowCursor;   sca
    return;
end

%% Page 2

break2txt = ['Let''s move on to the final block of trials'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, break2txt,'center', 'center', WhiteIndex(w)); % So here y = 270
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
    
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    Screen(w,'TextStyle',0);  % define font style to normal.
    Screen(w,'FillRect',[0 0 0]); % Set background colour to black
    
    oktxt_2 = ['Ok, let''s begin ..'];
    DrawFormattedText(w, oktxt_2,'center', 'center', WhiteIndex(w));
    Screen('Flip',w);
    WaitSecs(0.7);
    
    Screen('TextSize', w, par.txtsize);
    Screen('TextFont', w, 'Arial');
    Screen(w,'TextStyle',0);  % define font style to normal.
    Screen(w,'FillRect',[0 0 0]); % Set background colour to black
    
    oktxt_3 = ['Ok, let''s begin ...'];
    DrawFormattedText(w, oktxt_3,'center', 'center', WhiteIndex(w));
    Screen('Flip',w);
    WaitSecs(0.7);
    
end



