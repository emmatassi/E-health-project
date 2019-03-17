%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/simonepoli/Desktop/Processing text1.txt

% Initialize variables.
filename = '/Users/emmatassi/Desktop/E-Health/DATABASE/text.out.txt';
delimiter = {''};

% Format for each line of text:
%   column1: categorical (%C)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%C%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);

% Close the text file.
fclose(fileID);

% Create output variable
Processingtext6= table(dataArray{1:end-1}, 'VariableNames', {'Processingtext_000N_176842tx1Predictionofheightlimblengthandlim'});

% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;




