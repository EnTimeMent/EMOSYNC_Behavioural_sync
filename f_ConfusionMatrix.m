function  [A,IA,TA] = f_ConfusionMatrix(fA,YA,C)

% Columns of A are the OBServed values of YA
% Raws of A are the PREdicted values of fA
% A(i,j) = PREdicted C(i) and OBServed C(j)
% ! fA - rows
% ! YA - columns

NC = length(C); A = zeros(NC);
IA = cell(NC,NC); % YA = +1, fA = -1 false negatives
NP = []; % YA = -1, fA = +1 false positives
RN = cell(1,NC); CN = RN;

for ii = 1 : NC
    RN{ii} = ['Predict_',num2str(ii)];
    CN{ii} = ['Observe_',num2str(ii)];    
end

for ii = 1 : NC
    Cii = C(ii);
    for jj = 1 : NC
        
        Cjj = C(jj);
        A(ii,jj) = sum(and(fA == Cii, YA == Cjj));
        IA{ii,jj} = find(and(fA == Cii, YA == Cjj));
    end
end 

TA = array2table(A,'VariableNames',CN,'RowNames',RN);

% converts the M-by-N array A to an M-by-N table T.
%     Each column of A becomes a variable in T.
%  
%     NOTE:  A can be any type of array, including a cell array.  However, in that
%     case you probably want to use CELL2TABLE instead.  array2table creates the
%     variables in T from each column of A.  If A is a cell array, array2table
%     does not extract the contents of its cells -- T in this case is a table each
%     of whose variables is a column of cells.  To create a table from the
%     contents of the cells in A, use CELL2TABLE(A).
%  
%     T = array2table(X, 'PARAM1', VAL1, 'PARAM2', VAL2, ...) specifies optional
%     parameter name/value pairs that determine how the data in X are converted.
%  
%        'VariableNames'  A cell array of character vectors containing
%                         variable names for T.  The names must be valid
%                         MATLAB identifiers, and must be unique.
%        'RowNames'       A cell array of character vectors containing row
%                         names for T.  The names need not be valid MATLAB
%                         identifiers, but must be unique.
%  
%     See also table2array, cell2table, struct2table, table.
