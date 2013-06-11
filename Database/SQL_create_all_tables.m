function SQL_create_all_tables()
% Create all the tables in the database
% Uses SQL_tablecreatestring to retrieve the appropriate mySQL CREATE TABLE statements
% Romesh Abeysuriya, March 2013
% Ben Fulcher, now uses SQL_TableCreateString, May 2013

% Specify the names of tables to create (should be valid names in SQL_TableCreateString)
TableNames = {'Operations', ...     % Operations Table
        'MasterOperations', ...     % MasterOperations Table
        'MasterPointerRelate', ...  % MasterPointerRelate Table
        'TimeSeriesCategories', ... % TimeSeriesCategories Table
        'TimeSeriesDistributionCodes', ...    % Time Series distribution codes Table
        'TimeSeriesSource', ...     % TimeSeriesSource Table
        'TimeSeries', ...           % TimeSeries Table
        'TimeSeriesSourceRelate', ... % TimeSeriesSourceRelate Table
        'OperationKeywords', ...    % OperationKeywords Table
        'OpKeywordsRelate', ...        % mkwFileRelate Table
        'TimeSeriesKeywords', ...   % TimeSeriesKeywords
        'TsKeywordsRelate', ...       % TsKeywordsRelate Table
        'Results'};                 % Results Table

% Convert Table names to mySQL CREATE TABLE statements:
CreateString = arrayfun(@(x)SQL_TableCreateString(TableNames{x}),1:length(TableNames),'UniformOutput',0);

%% Write all of this to the database:
[dbc, dbname] = SQL_opendatabase; % opens dbc, the default database (named dbname)

fprintf(1,'Creating tables in %s\n',dbname);
for j = 1:length(CreateString)
    [rs,emsg] = mysql_dbexecute(dbc,CreateString{j});
    if ~isempty(rs)
        fprintf(1,'Created table: %s\n',TableNames{j});
    else
        fprintf(1,'**** Error creating table: %s\n',TableNames{j});
        fprintf(1,'%s',emsg);
    end
end
fprintf(1,'Tables created in %s\n',dbname);

SQL_closedatabase(dbc) % close the connection to the database

end