function eegdata = ReadEmotivEEGCSV(filename, dataLines)
% Usage: 
%   eegdata = ReadEmotivEEGCSV(filename) where filename is the exported csv
%
% AS22

% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [3, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 124);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Timestamp", "OriginalTimestamp", "EEGCounter", "EEGInterpolated", "EEGCz", "EEGFz", "EEGFp1", "EEGF7", "EEGF3", "EEGFC1", "EEGC3", "EEGFC5", "EEGFT9", "EEGT7", "EEGCP5", "EEGCP1", "EEGP3", "EEGP7", "EEGPO9", "EEGO1", "EEGPz", "EEGOz", "EEGO2", "EEGPO10", "EEGP8", "EEGP4", "EEGCP2", "EEGCP6", "EEGT8", "EEGFT10", "EEGFC6", "EEGC4", "EEGFC2", "EEGF4", "EEGF8", "EEGFp2", "EEGHighBitFlex", "EEGSaturationFlag", "EEGRawCq", "EEGBattery", "EEGBatteryPercent", "MarkerIndex", "MarkerType", "MarkerValueInt", "EEGMarkerHardware", "CQCz", "CQFz", "CQFp1", "CQF7", "CQF3", "CQFC1", "CQC3", "CQFC5", "CQFT9", "CQT7", "CQCP5", "CQCP1", "CQP3", "CQP7", "CQPO9", "CQO1", "CQPz", "CQOz", "CQO2", "CQPO10", "CQP8", "CQP4", "CQCP2", "CQCP6", "CQT8", "CQFT10", "CQFC6", "CQC4", "CQFC2", "CQF4", "CQF8", "CQFp2", "CQOverall", "EQSampleRateQuality", "EQOVERALL", "EQCz", "EQFz", "EQFp1", "EQF7", "EQF3", "EQFC1", "EQC3", "EQFC5", "EQFT9", "EQT7", "EQCP5", "EQCP1", "EQP3", "EQP7", "EQPO9", "EQO1", "EQPz", "EQOz", "EQO2", "EQPO10", "EQP8", "EQP4", "EQCP2", "EQCP6", "EQT8", "EQFT10", "EQFC6", "EQC4", "EQFC2", "EQF4", "EQF8", "EQFp2", "MOTCounterMems", "MOTInterpolatedMems", "MOTQ0", "MOTQ1", "MOTQ2", "MOTQ3", "MOTAccX", "MOTAccY", "MOTAccZ", "MOTMagX", "MOTMagY", "MOTMagZ"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "MarkerValueInt", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "MarkerValueInt", "EmptyFieldRule", "auto");

% Import the data
eegdata = readtable(filename, opts);

end