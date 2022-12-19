function data = ReadEmotivMarkerCSV(filename, dataLines)
% Usage: 
%   eegdata = ReadEmotivMarkerCSV(filename) where filename is the exported
%   csv of markers
%
% AS22

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 7);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["latency", "duration", "type", "marker_value", "key", "timestamp", "marker_id"];
opts.VariableTypes = ["double", "double", "categorical", "categorical", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["type", "marker_value"], "EmptyFieldRule", "auto");

% Import the data
data = readtable(filename, opts);

end