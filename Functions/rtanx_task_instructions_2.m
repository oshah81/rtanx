%% rtanx_task_instructions_2


%% Page 1

% Text
ExampleImage = ['The two images you see throughout the experiment will be different \n\n '...
    'colours, either blue or orange, like the ones below:'];
psbt = ['Press space bar to continue'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, ExampleImage,'center', par.monitor.screenYpixels/4 - par.monitor.screenYpixels*0.0926, WhiteIndex(w)); % So here y = 270
DrawFormattedText(w, psbt,'center', par.monitor.screenYpixels - par.monitor.screenYpixels/10,  par.col.tpred); %[0.5882,0,0.2]); % par.col.tpred

% Image

Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent - par.monitor.xCent*0.5209, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065, par.monitor.xCent - par.monitor.xCent*0.5209+400, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065+400]); % was 0.5926 for y // ok, was *0.2407 for resizing /// [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent + par.monitor.xCent*0.1042, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065, par.monitor.xCent + par.monitor.xCent*0.1042+400, par.monitor.screenYpixels - par.monitor.screenYpixels*0.2361]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue
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
% Probability of reward
probrewardtext1 = ['Each colour image is associated with a certain probability of reward \n\n '...
    'and the two probabilities always sum to 100% \n\n '...
    '\n\n '...
    'So, if the probability of the blue image rewarding is high, the probability \n\n '...
    'of the orange image rewarding will be low, for instance:'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
Screen(w,'TextStyle',0);  
Screen(w,'FillRect',[0 0 0]); % Set background colour to black

probmappingtxt_blue = ['Blue image rewards 90% of time'];
probmappingtxt_orange = ['Orange image rewards 10% of time'];

DrawFormattedText(w, probrewardtext1,'center', par.monitor.screenYpixels/4 - par.monitor.screenYpixels*0.1574, WhiteIndex(w));
DrawFormattedText(w, psbt,'center', par.monitor.screenYpixels - par.monitor.screenYpixels*0.1,  par.col.tpred); %[0.5882,0,0.2]); % par.col.tpred

% Image
Screen('PutImage',w, par.images.PracFrac1,[par.monitor.xCent - par.monitor.xCent*0.5209, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065, par.monitor.xCent - par.monitor.xCent*0.5209+400, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065+400]); % [460, 440, 860 ,820] took 20 off second coordinate to rescale to commensurate size
Screen('PutImage',w, par.images.PracFrac2,[par.monitor.xCent + par.monitor.xCent*0.1042, par.monitor.screenYpixels - par.monitor.screenYpixels*0.6065, par.monitor.xCent + par.monitor.xCent*0.1042+400, par.monitor.screenYpixels - par.monitor.screenYpixels*0.2361]); % [1060, 425, 1460, 825] then i took 15 off y coordinates of both to move oragne in line with blue

DrawFormattedText(w, probmappingtxt_blue, par.monitor.xCent - par.monitor.xCent*0.58, par.monitor.screenYpixels - par.monitor.screenYpixels*0.21, WhiteIndex(w));
DrawFormattedText(w, probmappingtxt_orange, par.monitor.xCent + par.monitor.xCent*0.03, par.monitor.screenYpixels - par.monitor.screenYpixels*0.21, WhiteIndex(w));


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


%% Pre Test

pretesttxt_1 = ['So, this means .'];
DrawFormattedText(w, pretesttxt_1,'center', 'center', WhiteIndex(w));
Screen('Flip',w);
WaitSecs(0.7);

pretesttxt_2 = ['So, this means ..'];
DrawFormattedText(w, pretesttxt_2,'center', 'center', WhiteIndex(w));
Screen('Flip',w);
WaitSecs(0.7);

pretesttxt_3 = ['So, this means ...'];
DrawFormattedText(w, pretesttxt_3,'center', 'center', WhiteIndex(w));
Screen('Flip',w);
WaitSecs(0.7);





