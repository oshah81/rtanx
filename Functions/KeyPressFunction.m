function [pressed,RT] = KeyPressFunction(AllowedKeys,TimeAllowed)
% This function waits for a key press given a list of allowed keys 
% [AllowedKeys], and a maximum reaction time [TimeAllowed] in seconds.  

% Input:
% AllowedKeys = Any keys that are used in the experiment. These must be
% defined in the main experiment script and should have elements of the 
% form KbName(DesiredKey). AllowedKeys is a vector. 

% TimeAllowed = The max time allowed for a keypress. The time is in 
% seconds. 

% Output:
% [pressed]= returns which of the allowed keys is pressed (1 = first key, 
% 2 =second key, etc), 0 = no key is pressed.

% [RT] = returns the reaction time of the keypress. 

    t0 = GetSecs; % get initial time t0
    PressKey = 0;  % variable to keep in while loop until correct keypress has been made
    while PressKey == 0; % loop until PressKey does not equal zero (allowed key has been pressed) 
        [t1, keyCode] = KbWait([],2,t0+TimeAllowed); % ...check if a key is being pressed until TimeAllowed is exceeded. All keys must be released before it checks the keypress (2). t1= time of the keypress, keycode=which keys are pressed.  
        RT=t1-t0; % Reaction time
        if any(keyCode)==1; % if a key has been pressed...
            for key = 1:length(AllowedKeys); %...check which key has been pressed by looping through all allowed keys.
                if keyCode(AllowedKeys(key))==1; % if one of the allowed keys is pressed...
                    PressKey = 1;  % ...get out of the loop...
                    pressed = key; % ...and save the key that was pressed
                end
            end 
        else  % if no key was pressed...
            PressKey=1; %...leave the loop...
            pressed = 0; % ...return 0...
            %RT=NaN; % ..and return reaction time = NaN. 
        end
    end
end

