% ========================================================================
% EnTimeMent project
% NOTICE : f_fig2jpg
% Fonction permettant de convertir des figures au format fig en images 
% au format jpg, et de les enregistrer. 
% Cette fonction a ete cree pour les cartes de chaleur et la renumerotation
% des images est adaptee a ces figures (suite de lettres, numero de la
% figure et extension '.fig').
% INPUT :
% * figDirectoryName : Dossier ou sont stocke les figures a convertir en
% jpg et a enregistrer.
% OUTPUT :
% Enregistrement des images au format jpg dans le meme dossier
% "figDirectoryName".
% ========================================================================

function [] = f_fig2jpg(figDirectoryName)

% INITIALISATION
filePattern = fullfile(figDirectoryName,  '*.fig');
figFiles = dir(filePattern);

% CREATION DU NOM DE L'IMAGE EN SORTIE :
% Detection du nombre de lettres avant le numero de la figure. 
j = 1;
nbLetters = 0;
name = figFiles(1).name;
while isnan(str2double(name(j))) || (str2double(name(j)) == 1i)
    nbLetters = nbLetters + 1;
    j = j + 1;
end

% Vecteur contenant la longueur des noms des figures.
figName_Vect = repmat(0, 1, length(figFiles));

for m = 1:length(figFiles)
    name = figFiles(m).name;
    figName_Vect(m) = strlength(string(name(nbLetters+1:end-4)));    
end

n_max = max(figName_Vect);
for k = 1 : length(figFiles)   
    % Création du nom de l'image en sortie.
    number = figFiles(k).name;
    n = number(nbLetters+1:(end-4));
    nZeros = '';
    
    if (n_max - strlength(n)) > 0
        nZeros = repmat('0', 1, n_max - strlength(n));
    end
    
    % ENREGISTREMENT DANS FIGDIRECTORYNAME : 
    figName = fullfile(figDirectoryName, figFiles(k).name);
    fig = openfig(figName, 'invisible');
    filename = fullfile(figDirectoryName, ['Figure', nZeros, n, '.jpg']);
    saveas(fig, filename);
    close all
end
