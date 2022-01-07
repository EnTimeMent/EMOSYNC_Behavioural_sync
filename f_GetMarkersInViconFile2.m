function markers = f_GetMarkersInViconFile2(FILENAME,Parameters)

% Find names of markers in Vicon file
% FILENAME - data file of trial

markers = {};
[fidF,msg] = fopen(FILENAME,'rt');
sep = Parameters.Separator;
if fidF ~= -1
    
    % Skip rows till Field #
    lx2 = fgets(fidF); vx2 = f_ScanLigne(lx2,sep); % Scan Line
    VX2 = vx2{1}; c = contains(VX2,'Field');
    while not(c)
        vx1 = vx2;
        lx2 = fgets(fidF); vx2 = f_ScanLigne(lx2,sep); % Scan Line
        VX2 = vx2{1}; c = contains(VX2,'Field');        
    end
    VX = vx1; LX = length(VX); markers = {};
    for k = 1 : LX
        vk = VX{k};
        if ~isempty(vk)
            markers = [markers;deblank(vk)];
        end
    end
    
    %     Close file
    s = fclose(fidF);
else
    error(['File: ',pathP,' not opened in read mode'])
end