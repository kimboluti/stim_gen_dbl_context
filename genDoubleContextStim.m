%% 2015-Jan-17-EKF: making flanker stim with same pitch as targets
%
%% Make stimuli for doubleContext experiment
%   the purpose of this script is to keep track of stim gen details for
%   this experiment. i did not always run CreateRhythm from this script,
%   but it should be possible to recreate what i did by manually entering
%   the bits from this script at the command line, if nothing else.
%
%   for all conditions:
%   toneDur = 50 ms
%   rampDur = 5 ms %both begin and end
%   padding = 20 ms %at begin and end of SEQUENCE to avoid clipping in
%   eprime
%
%   calls on CreateRhythm_FileRead.m
%   CreateRhythm pulls duration vector from user-selected Excel sheet,
%   which is different for each of the 3 context conditions
%
%   being lazy, i just ran CreateRhythm for each frequency combo i wanted,
%   except in the captorConditions, when that would've been absurd
%
%   parentFolder = 'C:\Users\Ellie\Documents\MATLAB\stim gen\doubleContext\samePitchFlankers\';

%% Single Context Condition (Flanker only) --**FLANKER-TARGET SAME PITCH
%dvec_filename = [parentFolder 'StimVectors_flankerConSeq_011715.csv'];
av = [0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];   %avec
fv = ones(1,length(av));    %freqvec
fvLowSame = [fv(1,1:13)*1975, fv(1,14:21)*1975];   %same-lowRange condition
fvLowFlipSame = [fv(1,1:13)*784, fv(1,14:21)*784];    %same-lowFlipRange condition


        IN CREATERHYTHM_FILEREAD_DC -- modified this section for wav filenames
        flankIOI = num2str(dvec_ms(j,3)+50);    %ITI after flanker is 3rd element, +50 for IOI
        compDur = num2str(dvec_ms(j,19)+50);    %ITI after comp is 19th element, +50 for IOI
        freqFlank = num2str(freqvec(1,1));      %1st half of freqvec has flanker pitch, element 14 onwards has target pitch
        freqTarget = num2str(freqvec(1,14));    %"target" = standard+comparison
        fname = strcat('freqFlank',freqFlank,'_flankIOI',flankIOI,'_freqTarget',freqTarget,'_compDur',num2str(compDur),'.wav');
        
CreateRhythm_FileRead_dC(av,fvLowSame,0);
CreateRhythm_FileRead_dC(av,fvLowFlipSame,0);

