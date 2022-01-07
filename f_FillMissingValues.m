function A = f_FillMissingValues(A,Parameters)

% Look for NaN Values in A
if any(any(isnan(A)))
    
    % Fill missing values
    wmv = Parameters.WidthMissingValues;
    d = numel(A(1,:));
    for i = 1 : d
        pp = A(:,i); cp = any(isnan(pp));
        while cp
            pp = fillmissing(pp,'movmedian',wmv);
            cp = any(isnan(pp));
        end
        A(:,i) = pp;
    end
end