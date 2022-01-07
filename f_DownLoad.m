function X2M = f_RapoDownLoad(FILENAME)

% Download and configures data RAPO_2_MTLB.csv file
% Input
% pathF - data file of session RAPO
% OBSOLETTE pathL - data file names of props and laws and default min/max values
% pathG - PICS_2_PROP1 vertical laws
% pathP - data file of PLEX interactions

Globals_ ; %Globals_Rapo;  % Load Global Variables

[fidF,msg] = fopen(FILENAME,'rt');
X2M.Bi = {}; X2M.Bj = {}; 
X2M.PlexCoeffs = zeros(1,4) + ValParDef;
if fidF ~= -1
    c = 1; cpt = 0;
    lx = fgets(fidF); % begin with second line
    
    while c  % Read File till the EOF
        lx = fgets(fidF); % begin with second line
        if lx ~= -1  % NOT EOF found
            cpt = cpt + 1;
            vx = f_ScanLigne(lx,';'); % Scan Line
            NOMSPROP{cpt} = vx{1};
            NOMSLAWS{cpt} = vx{2};
            z = str2double(vx(3 : end));
            BOUNDSBLEND = [BOUNDSBLEND; z(1 : 2)];
            BOUNDSPROPS = [BOUNDSPROPS; z(3 : 4)];
        else
            c = 0;
        end
    end
    
    Close file
    s = fclose(fidF);    
else
    sx = ['File: ',pathP,' not opened in read mode']; error(sx)
end