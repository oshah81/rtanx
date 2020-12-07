%% rtanx_final_slide

%% Page 1

% Text
finaltxt = ['Thank you, the task is now finished'];

Screen('TextSize', w, par.txtsize);
Screen('TextFont', w, 'Arial');
DrawFormattedText(w, finaltxt,'center','center', WhiteIndex(w)); 
Screen('Flip',w);

WaitSecs(3);
