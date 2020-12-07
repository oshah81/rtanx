%% Initialise

% This function establishes the probabilistic relationships between cues
% and outcomes and global par saettings for keyboard/images/colours

function [blocks, par] = rtanx_initialise

%% Global parameters 

% Keyboard
% Set same keyboard mapping on all supported operating systems.
KbName('UnifyKeyNames');

% Set used keys.
par.keys.spacebar = KbName('space');
par.keys.escapekey = KbName('ESCAPE');
par.keys.left = KbName('LeftArrow');
par.keys.right = KbName('RightArrow');
par.keys.one = KbName('1!');
par.keys.two = KbName('2@');
par.keys.three = KbName('3#');
par.keys.four = KbName('4$');

% Images

% Load images
% Practice
par.images.PracFrac1 = imread('images/pracStim1.bmp', 'bmp'); % Import practice stimulus 1 = blue.
par.images.PracFrac2 = imread('images/pracStim2.bmp', 'bmp'); % Import practice stimulus 2 = orange.
% Task Block 1
par.images.TB1Frac1 = imread('images/block1stim1.bmp', 'bmp'); % Import task 1 stimulus 1 = blue.
par.images.TB1Frac2 = imread('images/block1stim2.bmp', 'bmp'); % Import task 1 stimulus 2 = orange.
% Task Block 2
par.images.TB2Frac1 = imread('images/block2stim1.bmp', 'bmp'); % Import task 2 stimulus 1 = blue.
par.images.TB2Frac2 = imread('images/block2stim2.bmp', 'bmp'); % Import task 2 stimulus 2 = orange.

% Colour

par.col.tpred = [139,0,0];

% TextSize

par.txtsize = 35;

%% Task Settings & Probabilistic Mappings

n_trial_block_1 = 150;
n_trial_block_2 = 150;
n_blocks = 5; 

%% General Block Parameters

block_delta1 = [4  6 0 -4 -6]; % This way each of our ten blocks will be a slightly different lengths. Obviously, delta sums to 0
block_delta1 = block_delta1(randperm(length(block_delta1))); % Random perm the block lengths
block_lengths_1 = block_delta1 + n_trial_block_1/n_blocks; % Creates a 1*10 vector of total block lengths. 

block_delta2 = [4  6 0 -4 -6]; % This way each of our ten blocks will be a slightly different lengths. Obviously, delta sums to 0
block_delta2 = block_delta2(randperm(length(block_delta2))); % Random perm the block lengths
block_lengths_2 = block_delta2 + n_trial_block_2/n_blocks; % Creates a 1*10 vector of total block lengths. 

prac_block_lengths = block_lengths_1;
%% General Block Probabilistic Mapping 

contingencies = [ 50 50 ; 70 30 ; 90 10 ; 30 70 ; 10 90]; % Outcome contingeny mappings
% The first probability refers to that of a win following stimulus 1 (blue)
prac_contingencies = [ 70 30 ; 70 30 ; 70 30 ; 70 30 ; 70 30];

contingency_set = contingencies;
prac_contingency_set = prac_contingencies;

% Practice

prac_order = prac_contingency_set(randperm(length(prac_contingency_set)),:); 

% Block 1

block_order_1 = contingency_set(randperm(length(contingency_set)),:); % Random perm the contingency sets to get block order

% Block 2

block_order_2 = contingency_set(randperm(length(contingency_set)),:); % Random perm the contingency sets to get block order


%% Setting up cell arrays (stimuli, outcomes, screen position)

% Stimuli 

stimuli_1 = cell(n_blocks,1); % 10*1 cell array of empty matrices
% So it gives a 10*1 vector of 10*1 vectors choosing either stim 1 or stim 2 (at differeing lengths according to block_delta(11-12)/block_lengths(14)

% Outcomes

outcome_1 = cell(n_blocks,1); % 10*1 cell array of empty matrices - Same for outcomes.

% Stimuli positions on screen (Left - Right)

stimposition_1 = cell(n_blocks,1); % Creates identical cell array for position

%%                  Specific participant setup (BLock 1)

for q = 1:n_blocks  % q = block - from 1:10
    
    current_contingencies = block_order_1(q,:); 
    
    %% STIMULI & OUTCOMES ? Stim = (1 = BLUE / 2 = ORANGE)  // Outcome = (0 = Orange win / 1 = Blue win)
    
    stimuli_1{q} = [ones(block_lengths_1(q)/2,1); 2*ones(block_lengths_1(q)/2,1)]; % creates cell array of ones and twos (for image 1 or 2) according to block lengths generated earlier.
    stimuli_1{q} = stimuli_1{q}(randperm(length(stimuli_1{q}))); % Randomises the order of stimuli within those vectors.
        
     
    n_check_maria(q,1) = length(find(stimuli_1{q}<2)); % Should be uniformly distributed. 
    n_check_maria(q,2) = length(find(stimuli_1{q}>1)); % Should be uniformly distributed.
    
    % These should both be, if summed, the same as the block length for
    % this participant. This is because they should be equally distributed.
   
    len = round(current_contingencies*block_lengths_1(q)/100); % How many wins vs losses as a product of one blocks current contingency (and it's length). this should reflect current_contingencies up to the "rounded" approx
    out = [ones(1,len(1)), zeros(1,len(2))]; % this makes a vector of all the 1's and all the 0's that should be in each block according to 'len'. In this way we force a random choice from a predefined 'pile'.
    out = out'; % transpose 
    outcome_1{q} = out(randperm(length(out)),1); % Randomly shuffles the pile for selection.
    
    
    %% STIMULI POSITION = (1=LEFT / 2=RIGHT) Creating random stimuli presentation positions
    
    stimposition_1{q} = [ones(block_lengths_1(q)/2,1); 2*ones(block_lengths_1(q)/2,1)]; % Assign locations (1=left 2 = right)
    stimposition_1{q} = stimposition_1{q}(randperm(length(stimposition_1{q}))); % Randomly shuffle locations
    
end


%%                  Specific participant setup (BLock 2)

for q = 1:n_blocks  % q = block - from 1:10
    
    current_contingencies = block_order_2(q,:); 
    
    %% STIMULI & OUTCOMES ? Stim = (1 = BLUE / 2 = ORANGE)  // Outcome = (0 = Orange win / 1 = Blue win)
    
    stimuli_2{q} = [ones(block_lengths_2(q)/2,1); 2*ones(block_lengths_2(q)/2,1)]; % creates cell array of ones and twos (for image 1 or 2) according to block lengths generated earlier.
    stimuli_2{q} = stimuli_2{q}(randperm(length(stimuli_2{q}))); % Randomises the order of stimuli within those vectors.
        
     
    n_check_maria(q,1) = length(find(stimuli_2{q}<2)); % Should be uniformly distributed. 
    n_check_maria(q,2) = length(find(stimuli_2{q}>1)); % Should be uniformly distributed.
    
    % These should both be, if summed, the same as the block length for
    % this participant. This is because they should be equally distributed.
   
    len = round(current_contingencies*block_lengths_2(q)/100); % How many wins vs losses as a product of one blocks current contingency (and it's length). this should reflect current_contingencies up to the "rounded" approx
    out = [ones(1,len(1)), zeros(1,len(2))]; % this makes a vector of all the 1's and all the 0's that should be in each block according to 'len'. In this way we force a random choice from a predefined 'pile'.
    out = out'; % transpose 
    outcome_2{q} = out(randperm(length(out)),1); % Randomly shuffles the pile for selection.
    
    
    %% STIMULI POSITION = (1=LEFT / 2=RIGHT) Creating random stimuli presentation positions
    
    stimposition_2{q} = [ones(block_lengths_2(q)/2,1); 2*ones(block_lengths_2(q)/2,1)]; % Assign locations (1=left 2 = right)
    stimposition_2{q} = stimposition_2{q}(randperm(length(stimposition_2{q}))); % Randomly shuffle locations
    
end

%%                              Practice
for q = 1:n_blocks  % q = block - from 1:10
    
    prac_current_contingencies = prac_order(q,:); 
    
    %% STIMULI & OUTCOMES ? Stim = (1 = BLUE / 2 = ORANGE)  // Outcome = (0 = Orange win / 1 = Blue win)
    
    prac_stimuli_2{q} = [ones(block_lengths_2(q)/2,1); 2*ones(block_lengths_2(q)/2,1)]; % creates cell array of ones and twos (for image 1 or 2) according to block lengths generated earlier.
    prac_stimuli_2{q} = prac_stimuli_2{q}(randperm(length(prac_stimuli_2{q}))); % Randomises the order of stimuli within those vectors.
        
     
    prac_n_check_maria(q,1) = length(find(prac_stimuli_2{q}<2)); % Should be uniformly distributed. 
    prac_n_check_maria(q,2) = length(find(prac_stimuli_2{q}>1)); % Should be uniformly distributed.
    
    % These should both be, if summed, the same as the block length for
    % this participant. This is because they should be equally distributed.
   
    len = round(prac_current_contingencies*block_lengths_2(q)/100); % How many wins vs losses as a product of one blocks current contingency (and it's length). this should reflect current_contingencies up to the "rounded" approx
    out = [ones(1,len(1)), zeros(1,len(2))]; % this makes a vector of all the 1's and all the 0's that should be in each block according to 'len'. In this way we force a random choice from a predefined 'pile'.
    out = out'; % transpose 
    prac_outcome_2{q} = out(randperm(length(out)),1); % Randomly shuffles the pile for selection.
    
    
    %% STIMULI POSITION = (1=LEFT / 2=RIGHT) Creating random stimuli presentation positions
    
    prac_stimposition_2{q} = [ones(block_lengths_2(q)/2,1); 2*ones(block_lengths_2(q)/2,1)]; % Assign locations (1=left 2 = right)
    prac_stimposition_2{q} = prac_stimposition_2{q}(randperm(length(prac_stimposition_2{q}))); % Randomly shuffle locations
    
end
%% Compiling 

blocks.stimuli_1 = stimuli_1;
blocks.outcomes_1 = outcome_1;
blocks.stimposition_1 = stimposition_1;
blocks.stimuli_2 = stimuli_2;
blocks.outcomes_2 = outcome_2;
blocks.stimposition_2 = stimposition_2;
blocks.block1_order = block_order_1;
blocks.block2_order = block_order_2;
blocks.n_trial_1 = n_trial_block_1;
blocks.n_trial_2 = n_trial_block_2;
blocks.block1_id = [ones(block_lengths_1(1),1) ; 2* ones(block_lengths_1(2),1) ; 3 *ones(block_lengths_1(3),1) ; ...
    4*ones(block_lengths_1(4),1) ;  5*ones(block_lengths_1(5),1)];
blocks.block2_id = [ones(block_lengths_2(1),1) ; 2* ones(block_lengths_2(2),1) ; 3 *ones(block_lengths_2(3),1) ; ...
    4*ones(block_lengths_2(4),1) ;  5*ones(block_lengths_2(5),1)];

% Practice Compiling

prac_stimuli_1 = stimuli_1; prac_outcome_1 = outcome_1; prac_stimposition_1 = stimposition_1; 

blocks.prac_stimuli_1 = prac_stimuli_1;
blocks.prac_outcomes_1 = prac_outcome_1;
blocks.prac_stimposition_1 = prac_stimposition_1;
blocks.prac_order = prac_order;
blocks.prac_n_trial_1 = n_trial_block_1;
blocks.prac_block1_id = [ones(prac_block_lengths(1),1) ; 2* ones(prac_block_lengths(2),1) ; 3 *ones(prac_block_lengths(3),1) ; ...
    4*ones(prac_block_lengths(4),1) ;  5*ones(prac_block_lengths(5),1)];

end