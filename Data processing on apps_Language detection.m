% LAB 3.1: Data pre-processing
% Part of Language detection

%initializing the variables as cell arrays
languageDetected={};
%language that is detected by the python package lang_detect

accuracyDetected={};
%accuracy/probability for the top language

AppDescription={};
%Decription of the apps

fine=length(dataset.AppDescription);
AppDescription=dataset.AppDescription;
%extract the App Description from the table variable dataset

vectorDetected={};
numeroRiga=[];
language_en={};
accuracy_en={};

fine = size(dataset,1);

for i=1:fine %for-cicle from the first app to the last app in the struct
    
    text=AppDescription{i,1};
    %saving the App description as variable text
    
    try
        % using the "try and catch" form in order to override the default error
        % behaviour for a set of program statement
        try    
            match= ["&","+","*","-","\","%","#","!"]; 
            % match vector contains all the possible elements that could not be recognize during the language detection
            
            AppDescription_new=erase(text,match); 
            % deleting all the characters in match vector
            
            cut=extractBefore(text,200); 
            % extract all the characters from the beginning of text till the 200th position
        catch
            %if the text is not longer than the 200th position, is not
            %necessary to cut the text and the text is equal to the short App
            %Description
            
            match= ["&","+","*","-","\","%","#"];
            AppDescription_new=erase(text,match);
            
            cut=text;
        end
        
        %use the function detectLanguage calling the python package langdetect
        %from Matlab
        
        e=py.langdetect.detector_factory.detect_langs(AppDescription_new); 
        %extract the python package langdetect and save it as list variable
        
        wrapped=cell(e); %transform list variable into a cell array
        
        wrapped = cellfun(@char, wrapped, 'UniformOutput', false); 
        %apply char function and transform it into a char
        
        a=strsplit(wrapped{1,1},':'); %split wrapped variable
        
        %allocate language detected and accuracy detected into the cell array
        language=a{1,1};
        accuracy=a{1,2};
        
        %the accuracy detected is saved as a char, now it has to be a number in
        %order to compare it to the accuracy_number of 0.7
        
        accuracy_number=str2double(accuracy);
        
        %comparing the language detected and the string 'en' and return 1 if
        %the language detected is 'en'
        
        compare=strcmp(language,'en');
        
        %if the language detected is 'en' and the accuracy detected is higher
        %than 0.7, than the accuracy and the language are saved and the value of
        %vector variable is saved as 1, if the language detected is not 'en'
        %and the accuracy is lower than 0.7 than is saved 0 as vector variable
        
        if (compare == 1)
            if (accuracy_number>0.7)
                
                language_en =[language_en;language];
                accuracy_en=[accuracy_en;accuracy_number];
                
                vector=1;
            end
        else
            vector=0;
            
        end
        
        %creating a vector that contains 1 if the language detected is 'en' and
        %the accuracy is high, and 0 if the language detected is not 'en' and
        %the accuracy is lower
        
        vectorDetected=[vectorDetected; vector];
        
        %allocating the languages detected and the accuracies detected for each
        %apps in the cell array languafe detected and accuracy detected
        
        languageDetected =[languageDetected;language];
        accuracyDetected=[accuracyDetected;accuracy];
        
    catch
        %if there is no App Description for this App, the value of vector
        %is saved as 0 and the language detected and the accuracy detected
        %is saved as 'no description'
        
        vector=0;
        
        vectorDetected=[vectorDetected; vector];
        
        language= 'no description';
        languageDetected =[languageDetected;language];
        accuracy= 'no description';
        
        accuracyDetected=[accuracyDetected;accuracy];
        i=i+1;
        
    end
    
    % saving in numeroRiga the numbers of row  for which is found 0 in vector variable
    if(strfind(vector,0))
        numeroRiga = [numeroRiga i];
    end
    
    %creating a control variable in which is counted the number of 1 in the
    %cell array vectorDetected
    
    count=sum(cell2mat(vectorDetected));
    %the numbers of rows that will be deleted is the count variable
    %substracted from the length of vectorDetected
    
    
end

% recreate a struct from the table variable dataset
dataset_nuovo=table2struct(dataset,'ToScalar',true);

%recreate a table from struct variable dataset_nuovo
datasetFINAL=struct2table(dataset_nuovo);

%deleting the apps for which the language detected is not 'en' and the
%accuracy is not higher, the row of these apps was saved in numeroRiga
%To eliminate the app is necessary to assign [] to the row number of that app
datasetFINAL(numeroRiga,:)=[];


