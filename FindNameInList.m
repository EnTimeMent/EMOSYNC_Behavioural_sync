function iname = FindNameInList(List,Name,Flag)

% Return index iname of Name in List, 0 otherwise
L = numel(List); iname = 0;

for p = 1 : L
    switch Flag
        case 'Complete'
            in = strcmp(List{p},Name);
        case 'Contained'
            in = contains(List{p},Name);
    end
       
    if in, iname = p; break; end
end