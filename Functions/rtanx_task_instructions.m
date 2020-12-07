%% rtanx - Task Instructions

%% Welcome

% Set instruction page
weltxt = ['Welcome'];
Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, weltxt, 'center', 'center', WhiteIndex(w));
Screen('Flip',w);
% Wait
WaitSecs(3);

%% Page 1

pg1txt = ['In this experiment you will repeatedly choose between two images. \n\n'...
    'Your task is to discover which image is more rewarding.'];

psbt = ['Press space bar to continue'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, pg1txt,'center', par.monitor.yCent - par.monitor.yCent*0.30, WhiteIndex(w)); % par.monitor.screenYpixels/4
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

pg2txt = ['This will require you to learn about the likelihood that \n\n'...
            'different images are associated with winning or losing. \n\n'...
            '\n\n'...
            'After each prediction you will receive feedback about the outcome.'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, pg2txt,'center', par.monitor.yCent - par.monitor.yCent*0.30, WhiteIndex(w));
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

%% Page 3

pg3txt = ['Each correct prediction will earn you 5 pence (win) \n\n'...
            'Each incorrect prediction will earn you 0 pence (lose)'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, pg3txt,'center', par.monitor.yCent - par.monitor.yCent*0.30, WhiteIndex(w));
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
