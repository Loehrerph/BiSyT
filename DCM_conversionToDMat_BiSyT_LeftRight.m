load EEGchannels.mat
load Fiducials.mat




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import data from text file (avr BESA).

%% Initialize variables.

[filename, pathname]=uigetfile('*.avr','Select the left hand file ');  

cd (pathname)

delimiter = ' ';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fp = fopen(filename,'r');

%fp = fopen('os1_GN_left_OAR', 'r');

% MATLAB reserves file identifiers 0, 1, and 2 for standard input,  
% standard output (the screen), and standard error, respectively. When 
% fopen successfully opens a file, it returns a file identifier greater 
% than or equal to 3.
if(fp >= 3)
    
    % Get the first line of the file. It looks something like that:
    % Npts= 512   TSB= -400.000 DI= 3.125000 SB= 1.000 SC= 200.0 ...
    FirstLine = fgetl(fp);
    % First of all check if the parameter SegmentName exists.
    if(~isempty(strfind(FirstLine, 'SegmentName')))
        
        tmp = regexp(FirstLine, 'SegmentName= ', 'split');
        avr.SegmentName = tmp{2};
        FirstLine = tmp{1};
        
    end
    
    % Parse header information of .avr file.
    [DataParams] = sscanf(FirstLine, ...
        'Npts= %i TSB= %f DI= %f SB= %f SC= %f Nchan= %i');
    avr.Npts = DataParams(1);
    avr.TSB = DataParams(2);    
    avr.DI = DataParams(3);
    avr.Time = avr.TSB:avr.DI:avr.TSB+avr.DI*(avr.Npts-1);
    
    if(size(DataParams, 2) > 5)
        
        avr.Nchan = DataParams(6);
        
    end
    
    avr.ChannelLabels = [];
    
    % The second line could contain the channel labels but it also could be
    % that it contains data.
    SecondLine = fgetl(fp);
    
    % Check if the second line contains labels or data values
    Characters = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' ...
        'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
    NumChars = size(Characters, 2);
    iCounter = 1;
    bContainsCharacter = 0;
    for ch = 1:NumChars
        
        % If the second line contains characters then these are the channel
        % labels.
        if(~isempty(regexpi(SecondLine, Characters{ch}, 'match')))
            
            avr.ChannelLabels = SecondLine;
            bContainsCharacter = 1;
            break;
        
        end
        
    end
    
    % If the second line does not contain characters then these are no
    % labels but data instead.
    if(bContainsCharacter == 0)
        
        avr.Data(iCounter, :) = sscanf(SecondLine, '%f', [avr.Npts,1]);
        iCounter = 2;
        
    end

    while(true)
        
        CurrentLine = fgetl(fp);
        % Check if end of file.
        if(~ischar(CurrentLine))
            
            break;
            
        end
        
        avr.Data(iCounter, :) = sscanf(CurrentLine, '%f', [avr.Npts,1]);
        iCounter = iCounter + 1;
        
    end
    
    avr.Nchan=size(avr.Data, 1);
    
    fclose(fp);
    
else
    
    avr = [];
    disp('Error! Invalid file identifier.')
    
end

leftHand = avr.Data;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear avr 

%% Initialize variables.

[filename, pathname]=uigetfile('*.avr','Select the right hands file '); 

cd (pathname)

delimiter = ' ';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fp = fopen(filename,'r');


if(fp >= 3)
    
    % Get the first line of the file. It looks something like that:
    % Npts= 512   TSB= -400.000 DI= 3.125000 SB= 1.000 SC= 200.0 ...
    FirstLine = fgetl(fp);
    % First of all check if the parameter SegmentName exists.
    if(~isempty(strfind(FirstLine, 'SegmentName')))
        
        tmp = regexp(FirstLine, 'SegmentName= ', 'split');
        avr.SegmentName = tmp{2};
        FirstLine = tmp{1};
        
    end
    
    % Parse header information of .avr file.
    [DataParams] = sscanf(FirstLine, ...
        'Npts= %i TSB= %f DI= %f SB= %f SC= %f Nchan= %i');
    avr.Npts = DataParams(1);
    avr.TSB = DataParams(2);    
    avr.DI = DataParams(3);
    avr.Time = avr.TSB:avr.DI:avr.TSB+avr.DI*(avr.Npts-1);
    
    if(size(DataParams, 2) > 5)
        
        avr.Nchan = DataParams(6);
        
    end
    
    avr.ChannelLabels = [];
    
    % The second line could contain the channel labels but it also could be
    % that it contains data.
    SecondLine = fgetl(fp);
    
    % Check if the second line contains labels or data values
    Characters = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' ...
        'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
    NumChars = size(Characters, 2);
    iCounter = 1;
    bContainsCharacter = 0;
    for ch = 1:NumChars
        
        % If the second line contains characters then these are the channel
        % labels.
        if(~isempty(regexpi(SecondLine, Characters{ch}, 'match')))
            
            avr.ChannelLabels = SecondLine;
            bContainsCharacter = 1;
            break;
        
        end
        
    end
    
    % If the second line does not contain characters then these are no
    % labels but data instead.
    if(bContainsCharacter == 0)
        
        avr.Data(iCounter, :) = sscanf(SecondLine, '%f', [avr.Npts,1]);
        iCounter = 2;
        
    end

    while(true)
        
        CurrentLine = fgetl(fp);
        % Check if end of file.
        if(~ischar(CurrentLine))
            
            break;
            
        end
        
        avr.Data(iCounter, :) = sscanf(CurrentLine, '%f', [avr.Npts,1]);
        iCounter = iCounter + 1;
        
    end
    
    avr.Nchan=size(avr.Data, 1);
    
    fclose(fp);
    
else
    
    avr = [];
    disp('Error! Invalid file identifier.')
    
end

rightHand = avr.Data;

leftHand = leftHand(:,501:1500);
rightHand = rightHand(:,501:1500);

clearvars -except leftHand rightHand pathname filename ChannelLabels Sensors Fiducials

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert grand averages into an format that can be read into
% a 'D' file that can be read by SPM12, and performs some basic
% preprocessing (filtering, downsampling). Returns the final 'D' struct and
% writes all results to disk.
%
% Usage:
%     spm eeg
%     single_convert_fj

% Hard-coded settings
fq = 250;  % downsampling frequency [Hz]

% =====================================================================
% create ftdata struct

% Construct FieldTrip struct
disp(['Constructing FieldTrip struct...']);
ftdata = [];
ftdata.fsample = 1000;

% - cell array of CHANNELS x TIME matrices from each condition (averaged)
% - cell array of (identical) time vectors
nChannels = 127; % number of channels
nBins = 1000; % number of bins
ftdata.trial = cell(1,1); 
ftdata.time = cell(1,1);

% Load files
disp(['Loading data...']);

ftdata.trial{1} = leftHand; % channels x bins
ftdata.trial{2} = rightHand ; % channels x bins

ftdata.time{1} = [0:nBins-1]/ftdata.fsample;
ftdata.time{2} = [0:nBins-1]/ftdata.fsample;

% - cell array of strings: list of channel names
ftdata.label = cell(nChannels,1);
ftdata.type = cell(nChannels,1);

for c = 1:nChannels
    
    ftdata.label{c} = [ChannelLabels{c,1}];
end


this.sensors = 'EEG';
this.fiducials = double([]);
this.artifacts = struct([]);
this.other = struct([]); 
%  
% =====================================================================
% Part 3: convert ftdata struct to SPM struct

% Create output directory
disp(['Converting FieldTrip struct to SPM struct...']);
dirOut = makeAbsolutePath(fullfile(pathname));

% Convert the ftdata struct to SPM M/EEG dataset
% and save to disk (--> 'D')
fileD = 'D.mat';
file = fullfile(dirOut,fileD);
D = spm_eeg_ft2spm(ftdata, file);

% Set condition names
D = conditions(D,1,'left hand random');
D = conditions(D,2,'right hand random');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% Save changes, clear, load again
D.save;
file = fullfile(dirOut, fileD);
D = spm_eeg_load(file);

% Filtering (--> 'fD')
file = fullfile(dirOut, fileD);
S = [];
S.D = file;
S.type = 'butterworth';
S.band = 'bandpass';
S.freq =[1 48] ;

D = spm_eeg_filter(S);

% Downsampling (--> 'dfD')
file = fullfile(dirOut, ['f', fileD]);
S = [];
S.D = file;
S.fsample_new = fq; % #### Hz #####
D = spm_eeg_downsample(S);

% Done
disp([' ']);
disp('Conversion completed.');
disp([' ']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except ChannelLabels Sensors Fiducials
load dfD.mat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Import BadChannel File

%% Initialize variables.

[BadChannelFile]=uigetfile('*.bad','Select bad channel file ');  

delimiter = ' ';


%% Format string for each line of text:
%   column1: text (%s)
%	column2: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(BadChannelFile,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);


%% Allocate imported array to column variable names

NamesOfBC = dataArray{:, 1};
NumberOfBC = dataArray{:, 2};

%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;

for i = 1:127
    %var = [];
    var = strcmp (D.channels(i).label, NamesOfBC);
    
    if sum(var) == 1 
    
        D.channels(i).bad = 1;
    else     
       
       D.channels(i).bad = 0;
       
    end
 
    D.channels(i).type = 'EEG';
    D.channels(i).units = 'uV';
end 

D.condlist{1,1} ='A';
D.condlist{1,2} ='B';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set fiducials

D.sensors = Sensors;
D.fiducials = Fiducials;

clearvars -except D

save('dfD.mat', 'D')

SumBC  = sum([D.channels(:).bad]);
text = 'number of bad channels is ';
disp(text) 
disp(SumBC)
