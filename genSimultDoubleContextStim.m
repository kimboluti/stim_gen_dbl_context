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
%   parentFolder = 'R:\PROJECTS\doubleContext\materials\stimGen_MATLAB\';

%% Control Condition
%dvec_filename = [parentFolder 'StimVectors_controlSeq_010515.csv'];
av = [0 1 0 1 0 1 0 1 0];   %avec
fv = ones(1,length(av));    %freqvec
fv1975 = fv*1975;   %to match below-lowRange condition
fv2217 = fv*2217;   %to match below-hiRange condition
fv880 = fv*880;   %to match above-lowflipRange condition
fv784 = fv*784;   %to match above-hiflipRange condition

        IN CREATERHYTHM_FILEREAD_DC -- modified this section for wav filenames
        compDur = num2str(dvec_ms(j,7)+50); %compDur was in 7th element of dvec; +50 because we want IOI not ITI
        freq = num2str(freqvec(1,1));
        fname = strcat('freq',freq,'_compDur',num2str(compDur),'.wav');

CreateRhythm_FileRead_dC(av,fv1975,0);
CreateRhythm_FileRead_dC(av,fv2217,0);
CreateRhythm_FileRead_dC(av,fv880,0);
CreateRhythm_FileRead_dC(av,fv784,0);

%% Single Context Condition (Flanker only)
%dvec_filename = [parentFolder 'StimVectors_flankerConSeq_010515.csv'];
av = [0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];   %avec
fv = ones(1,length(av));    %freqvec
fvLowBelow = [fv(1,1:13)*1318, fv(1,14:21)*1975];   %below-lowRange condition
fvHiBelow = [fv(1,1:13)*1480, fv(1,14:21)*2217];    %below-hiRange condition
fvLowAbove = [fv(1,1:13)*1244, fv(1,14:21)*784];    %above-lowFlipRange condition
fvHiAbove = [fv(1,1:13)*1396, fv(1,14:21)*880];     %above-hiFlipRange condition

        IN CREATERHYTHM_FILEREAD_DC -- modified this section for wav filenames
        flankIOI = num2str(dvec_ms(j,3)+50);    %ITI after flanker is 3rd element, +50 for IOI
        compDur = num2str(dvec_ms(j,19)+50);    %ITI after comp is 19th element, +50 for IOI
        freqFlank = num2str(freqvec(1,1));      %1st half of freqvec has flanker pitch, element 14 onwards has target pitch
        freqTarget = num2str(freqvec(1,14));    %"target" = standard+comparison
        fname = strcat('freqFlank',freqFlank,'_flankIOI',flankIOI,'_freqTarget',freqTarget,'_compDur',num2str(compDur),'.wav');
        
CreateRhythm_FileRead_dC(av,fvLowBelow,0);
CreateRhythm_FileRead_dC(av,fvHiBelow,0);
CreateRhythm_FileRead_dC(av,fvLowAbove,0);
CreateRhythm_FileRead_dC(av,fvHiAbove,0);

%% Double Context Condition (Capture + Flanker)
dvec_filename = [parentFolder 'StimVectors_captureConSeq_011615.csv'];
av = [0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];   %avec from flanker condition
av = [av 1 0 1 0 1 0 1 0 1 0 1 0];  %avec adding to flanker condition
fv = ones(1,length(av));    %freqvec                                      
fvLowBelow_same = [fv(1:13)*1318, fv(1,14:25)*1318, fv(1,26:33)*1975];   %below-lowRange, c=f condition
fvHiBelow_same = [fv(1:13)*1480, fv(1,14:25)*1480, fv(1,26:33)*2217];    %below-hiRange, c=f condition
fvLowAbove_same = [fv(1:13)*1244, fv(1,14:25)*1244, fv(1,26:33)*784];    %above-lowFlipRange, c=f condition
fvHiAbove_same = [fv(1:13)*1396, fv(1,14:25)*1396, fv(1,26:33)*880];     %above-hiFlipRange, c=f condition

fvLowBelow_near = [fv(1:13)*1244, fv(1,14:25)*1318, fv(1,26:33)*1975];   %below-lowRange, c near condition
fvHiBelow_near = [fv(1:13)*1396, fv(1,14:25)*1480, fv(1,26:33)*2217];    %below-hiRange, c near condition
fvLowAbove_near = [fv(1:13)*1318, fv(1,14:25)*1244, fv(1,26:33)*784];    %above-lowFlipRange, c near condition
fvHiAbove_near = [fv(1:13)*1480, fv(1,14:25)*1396, fv(1,26:33)*880];     %above-hiFlipRange, c near condition

fvLowBelow_far = [fv(1:13)*784, fv(1,14:25)*1318, fv(1,26:33)*1975];   %below-lowRange, c far condition
fvHiBelow_far = [fv(1:13)*880, fv(1,14:25)*1480, fv(1,26:33)*2217];    %below-hiRange, c far condition
fvLowAbove_far = [fv(1:13)*1975, fv(1,14:25)*1244, fv(1,26:33)*784];    %above-lowFlipRange, c far condition
fvHiAbove_far = [fv(1:13)*2217, fv(1,14:25)*1396, fv(1,26:33)*880];     %above-hiFlipRange, c far condition

% I think life will be easier if I put this into a matrix:
bigFreqMatrix = [fvLowBelow_same; fvHiBelow_same; fvLowAbove_same; fvHiAbove_same;...
    fvLowBelow_near; fvHiBelow_near; fvLowAbove_near; fvHiAbove_near;...
    fvLowBelow_far; fvHiBelow_far; fvLowAbove_far; fvHiAbove_far];
 
 
        IN CREATERHYTHM_FILEREAD_DC -- modified this section for wav filenames
        captIOI = num2str(dvec_ms(j,3)+50); %ITI after captor is 3rd element, +50 for IOI
        flankIOI = num2str(dvec_ms(j,15)+50);    %ITI after flanker is 15th element, +50 for IOI
        compDur = num2str(dvec_ms(j,31)+50);    %ITI after comp is 31st element, +50 for IOI
        
        freqCapt = num2str(freqvec(1,1));   %1st half of freqvec has captor pitch, element 14 onwards has flanker pitch, element 26 onwards has target pitch
        freqFlank = num2str(freqvec(1,14));      
        freqTarget = num2str(freqvec(1,26));    %"target" = standard+comparison
        
        fname = strcat('freqCapt',freqCapt,'_captIOI',captIOI,'_freqFlank',freqFlank,'_flankIOI',flankIOI,'_freqTarget',freqTarget,'_compDur',num2str(compDur),'.wav');


        
%% For some reason, this (below) didn't work, I ended up entering what's below this...
% create all 324 possible stimuli...(12 frequency conditions * 27 duration conditions) 
numFreqConds = size(bigFreqMatrix,1);

        for i = numFreqConds
            fvec = bigFreqMatrix(i,:);
            CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,fvec,0);
            i = i+1;
        end;

% this worked though I need to verify things are correct
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(1,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(2,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(3,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(4,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(5,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(6,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(7,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(8,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(9,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(10,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(11,:),0);
CreateRhythm_FileRead_dC_captorCond(dvec_filename,av,bigFreqMatrix(12,:),0);


%% Just a test with frequency range more similar to Nate's experiment

...
