function y = Y_Import1(FILENAME)

% Find Emotion information into Trial file
% FILENAME - data file of trial

[fidF,msg] = fopen(FILENAME,'rt');
y = []; % Default value

if fidF ~= -1
    while ~feof(fidF)  % Read File till the EOF
        lx = fgets(fidF); % begin with second line
        vx = f_ScanLigne(lx,';'); % Scan Line
        if contains(vx{1},'Emot')
            y = str2double(vx{2});
            break
        end
    end
    
    %     Close file
    s = fclose(fidF);
else
    error(['File: ',pathP,' not opened in read mode'])
end