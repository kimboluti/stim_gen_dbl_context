function m = CreateRhythm_FileRead_dC(avec,freqvec,flag)

%dvec_ms = vector of durations in ms; will be obtained from excel;
%avec = vector of amplitudes in 0 - 1 range;
%freqvec = vector of frequencies of each tone in hertz;

fs = 44100;        %sampling rate.
rdur = 5;          %ramp duration in ms.

[filename, pathname] = uigetfile;
full_path = strcat(pathname, filename);

dvec_ms = csvread(full_path);

n1 = size(dvec_ms,2);  %duration vec
n1b = size(dvec_ms,1); %number of levels (rows)
n2 = length(avec);  %amplitude vector to specific intensity of each tone
n3 = length(freqvec); %frequency vector to specify pitch of each tone

dvec = dvec_ms/1000;  %make sure that elements of duration vector are in sec.

for j=1:n1b %to make a sound file for each row of dvec
    
        svec = [];
        for i = 1:n1
            svec = [svec,ramp_sound(MakeSineTone(freqvec(i),dvec(j,i),avec(i),fs,0),rdur,fs)];
        end

        if (flag == 1) 
            wavplay(svec,fs);
        end

    svec = svec*0.99; %prevent clipping
    
        flankIOI = num2str(dvec_ms(j,3)+50);    %ITI after flanker is 3rd element, +50 for IOI
        compDur = num2str(dvec_ms(j,19)+50);    %ITI after comp is 19th element, +50 for IOI
        freqFlank = num2str(freqvec(1,1));      %1st half of freqvec has flanker pitch, element 14 onwards has target pitch
        freqTarget = num2str(freqvec(1,14));    %"target" = standard+comparison
        fname = strcat('freqFlank',freqFlank,'_flankIOI',flankIOI,'_freqTarget',freqTarget,'_compDur',num2str(compDur),'.wav');
      
    
    wavwrite(svec,fs,fname);
end
    
end
