clear all
%% Load all
% Specify the directory containing the .mat files
folderPath = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\saved_data';

% Get a list of all files in the folder and subfolders with the .mat extension
matFiles = dir(fullfile(folderPath, '**', '*.mat'));  % '**' enables recursive search in subfolders

% Loop through each file and load it
for k = 1:length(matFiles)
    filePath = fullfile(matFiles(k).folder, matFiles(k).name);
    data = load(filePath);
    
    % Assuming each .mat file contains only one variable and can be converted to a double
    varNames = fieldnames(data);  % Get the name of the variable in the .mat file
    if length(varNames) == 1  % Check if there's exactly one variable in the file
        varData = data.(varNames{1});  % Extract that variable
        
        % Check if the data can be converted to a double
        if isnumeric(varData) || islogical(varData)
            varData = double(varData);  % Convert to double if not already
            % Store it in a variable dynamically named according to the file without the loop index
            eval([varNames{1}, ' = varData;']);  % Remove num2str(k) to prevent indexing by load order
        else
            warning('%s contains data that cannot be converted to double.', matFiles(k).name);
        end
    else
        warning('%s does not contain exactly one variable.', matFiles(k).name);
    end
end
clear matFiles filePath folderPath varNames varData data k
%% 


% Specify the directory containing the .mat files
folderPath = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\saved_data\Traces';

% Get a list of all files in the folder with the .mat extension
matFiles = dir(fullfile(folderPath, '*.mat'));

% Loop through each file and load it
for k = 1:length(matFiles)
    filePath = fullfile(folderPath, matFiles(k).name);
    data = load(filePath);
    
    % Assuming each .mat file contains only one variable and can be converted to a double
    varNames = fieldnames(data);  % Get the name of the variable in the .mat file
    if length(varNames) == 1  % Check if there's exactly one variable in the file
        varData = data.(varNames{1});  % Extract that variable
        
        % Check if the data can be converted to a double
        if isnumeric(varData) || islogical(varData)
            varData = double(varData);  % Convert to double if not already
            % Store it in a variable dynamically named according to the file without the loop index
            eval([varNames{1}, ' = varData;']);  % Remove num2str(k) to prevent indexing by load order
        else
            warning('%s contains data that cannot be converted to double.', matFiles(k).name);
        end
    else
        warning('%s does not contain exactly one variable.', matFiles(k).name);
    end
end

% Specify the directory containing the .mat files
folderPath = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\saved_data\Troughs';

% Get a list of all files in the folder with the .mat extension
matFiles = dir(fullfile(folderPath, '*.mat'));

% Loop through each file and load it
for k = 1:length(matFiles)
    filePath = fullfile(folderPath, matFiles(k).name);
    data = load(filePath);
    
    % Assuming each .mat file contains only one variable and can be converted to a double
    varNames = fieldnames(data);  % Get the name of the variable in the .mat file
    if length(varNames) == 1  % Check if there's exactly one variable in the file
        varData = data.(varNames{1});  % Extract that variable
        
        % Check if the data can be converted to a double
        if isnumeric(varData) || islogical(varData)
            varData = double(varData);  % Convert to double if not already
            % Store it in a variable dynamically named according to the file without the loop index
            eval([varNames{1}, ' = varData;']);  % Remove num2str(k) to prevent indexing by load order
        else
            warning('%s contains data that cannot be converted to double.', matFiles(k).name);
        end
    else
        warning('%s does not contain exactly one variable.', matFiles(k).name);
    end
end

% Specify the directory containing the .mat files
folderPath = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\saved_data\RR_intervals';

% Get a list of all files in the folder with the .mat extension
matFiles = dir(fullfile(folderPath, '*.mat'));

% Loop through each file and load it
for k = 1:length(matFiles)
    filePath = fullfile(folderPath, matFiles(k).name);
    data = load(filePath);
    
    % Assuming each .mat file contains only one variable and can be converted to a double
    varNames = fieldnames(data);  % Get the name of the variable in the .mat file
    if length(varNames) == 1  % Check if there's exactly one variable in the file
        varData = data.(varNames{1});  % Extract that variable
        
        % Check if the data can be converted to a double
        if isnumeric(varData) || islogical(varData)
            varData = double(varData);  % Convert to double if not already
            % Store it in a variable dynamically named according to the file without the loop index
            eval([varNames{1}, ' = varData;']);  % Remove num2str(k) to prevent indexing by load order
        else
            warning('%s contains data that cannot be converted to double.', matFiles(k).name);
        end
    else
        warning('%s does not contain exactly one variable.', matFiles(k).name);
    end
end

% Specify the directory containing the .mat files
folderPath = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\saved_data\Sleep';

% Get a list of all files in the folder with the .mat extension
matFiles = dir(fullfile(folderPath, '*.mat'));

% Loop through each file and load it
for k = 1:length(matFiles)
    filePath = fullfile(folderPath, matFiles(k).name);
    data = load(filePath);
    
    % Assuming each .mat file contains only one variable and can be converted to a double
    varNames = fieldnames(data);  % Get the name of the variable in the .mat file
    if length(varNames) == 1  % Check if there's exactly one variable in the file
        varData = data.(varNames{1});  % Extract that variable
        
        % Check if the data can be converted to a double
        if isnumeric(varData) || islogical(varData)
            varData = double(varData);  % Convert to double if not already
            % Store it in a variable dynamically named according to the file without the loop index
            eval([varNames{1}, ' = varData;']);  % Remove num2str(k) to prevent indexing by load order
        else
            warning('%s contains data that cannot be converted to double.', matFiles(k).name);
        end
    else
        warning('%s does not contain exactly one variable.', matFiles(k).name);
    end
end
clear matFiles filePath folderPath varNames varData data