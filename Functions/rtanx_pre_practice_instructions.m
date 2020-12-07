%% rtanx_pre_practice_instructions

%% Page 1

% Example of images used

% Text
final_txt = ['Good. You should now be familiar with how the experiment works. \n\n '...
    '\n\n '...
    'To recap: you will be shown a series of images and your goal is  \n\n '...
    'to predict which one is more rewarding over the course of the task  \n\n '...
     '\n\n '...
    'For each correct prediction you earn + 3p (win!), \n\n '...
    'For each incorrect prediction, you lose out: 0p (lose!) \n\n '...
    ' \n\n '...
    'Make your predictions quickly, otherwise the trial expires and  \n\n '...
    'you lose the chance to win more money!'];

psbt = ['Press space bar to continue'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, final_txt,'center', par.monitor.screenYpixels/4 - par.monitor.screenYpixels*0.0926, WhiteIndex(w)); % So here y = 270 // 
DrawFormattedText(w, psbt,'center', par.monitor.screenYpixels - par.monitor.screenYpixels*0.1,  par.col.tpred); %[0.5882,0,0.2]); % par.col.tpred

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