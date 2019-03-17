%% LAB 1

url1= 'https://itunes.apple.com/us/genre/ios-medical/id6020?mt=8&letter=A&page=1#page';
url2 = 'https://itunes.apple.com/us/genre/ios-health-fitness/id6013?mt=8&letter=A&page=1#page';
urltot = {url1;url2};
%defining and initial url (by default on letter A)

alfabeto = ['A'];
%I create a vector alphabet which contains all the letters of the alphabet

for a = 1:length(urltot) %doing a loop for both categories of interest
    
    Dataset = {};
    %preallocate the variable Dataset
    
    url = urltot(a);
    %Select the url where I'll find all the apps
    
    urlSplit = split(url,{'?mt=8&letter=','&'});
    %splittng the URL in 3 parts: in cell number 2 I'll find the letter of the page
    
    for i = 1:length(alfabeto) %cicling on all the alphabet
        
        urlSplit{2}=alfabeto(i);
        %putting in cell 2 the letter of the alphabet which I find apps
        
        urlAttached = strjoin(urlSplit,{'?mt=8&letter=','&'});
        %'re-attaching' the url together
        
        options = weboptions('Timeout',60);
        S1 = webread(urlAttached,options);
        %reading the url
        
        pattern = ' <ul class="list paginate"><li><a(.*?)</a></li></ul>';
        %creating a pattern that allows to search for the number of pages
        
        URLnumero = regexp(S1, pattern,'match');
        %creating an array containing all the URLs of the numbers
        
        if(isempty(URLnumero) == 1)
            %if I have an array with only one url it means that I have only one page
            numeroPagine = 1;
        else
            
            arrayNumeri = split(URLnumero(1),{'#page">','</a></li>'});
            numeroChar = arrayNumeri{length(arrayNumeri)-2};
            numeroPagine = str2double(numeroChar);
            %finding the number of the last page
            
            if (numeroPagine == 18)
                %if I get up to 18, it means that I have other pages after the 18th
                
                urlSplit18 = split(urlAttached,{'&page=','#page'});
                %breaking the url again to insert 18
                
                urlSplit18{2}='18';
                %replace 18 within the url
                
                urlAttached18 = strjoin(urlSplit18,{'&page=','#page'});
                %re-attaching the url
                
                S18 = webread(urlAttached18);
                %reading the url
                
                pattern18 = ' <ul class="list paginate"><li><a(.*?)</a></li></ul>';
                %taking everything in between with (.*?)
                
                URLnumero18 = regexp(S18, pattern18,'match');
                %creating an array with all the urls
                
                arrayNumeri18 = split(URLnumero18(1),{'#page">','</a></li>'});
                numeroChar18 = arrayNumeri18{length(arrayNumeri18)-2};
                numeroPagine = str2double(numeroChar18);
                
                if isnan(numeroPagine) %control
                    arrayNumeri18 = split(URLnumero18(1),{'page=','#page"'});
                    numeroChar18 = arrayNumeri18{length(arrayNumeri18)-1};
                    numeroPagine = str2double(numeroChar18);
                end
                
                if (numeroPagine == 26)
                    %if I get up to 26, it means that I have other pages after the 26th
                    
                    urlSplit26 = split(urlAttached18,{'&page=','#page'});
                    %breaking the url again to insert 26
                    
                    urlSplit26{2}='26';
                    %replace 26 within the url
                    
                    urlAttached26 = strjoin(urlSplit26,{'&page=','#page'});
                    %re-attaching the url
                    
                    S26 = webread(urlAttached26);
                    %reading the url
                    
                    pattern26 = ' <ul class="list paginate"><li><a(.*?)</a></li></ul>';
                    %taking everything in between with (.*?)
                    
                    URLnumero26 = regexp(S26, pattern26,'match');
                    %creating an array with all the urls
                    
                    arrayNumeri26 = split(URLnumero26(1),{'#page">','</a></li>'});
                    numeroChar26 = arrayNumeri26{length(arrayNumeri26)-2};
                    numeroPagine = str2double(numeroChar26);
                    
                    if isnan(numeroPagine) %control
                        arrayNumeri26 = split(URLnumero26(1),{'page=','#page"'});
                        numeroChar26 = arrayNumeri26{length(arrayNumeri26)-1};
                        numeroPagine = str2double(numeroChar26);
                    end
                    
                    if (numeroPagine == 34)
                        %if I get up to 34, it means that I have other pages after the 34th
                        
                        urlSplit34 = split(urlAttached26,{'&page=','#page'});
                        %breaking the url again to insert 34
                        
                        urlSplit34{2}='34';
                        %replace 34 within the url
                        
                        urlAttached34 = strjoin(urlSplit34,{'&page=','#page'});
                        %re-attaching the url
                        
                        S34 = webread(urlAttached34);
                        %reading the url
                        
                        pattern34 = ' <ul class="list paginate"><li><a(.*?)</a></li></ul>';
                        %taking everything in between with (.*?)
                        
                        URLnumero34 = regexp(S34, pattern34,'match');
                        %creating an array with all the urls
                        
                        arrayNumeri34 = split(URLnumero34(1),{'#page">','</a></li>'});
                        numeroChar34 = arrayNumeri34{length(arrayNumeri34)-2};
                        numeroPagine = str2double(numeroChar34);
                        
                        if isnan(numeroPagine) %control
                            arrayNumeri34 = split(URLnumero34(1),{'page=','#page"'});
                            numeroChar34 = arrayNumeri34{length(arrayNumeri34)-1};
                            numeroPagine = str2double(numeroChar34);
                        end
                        
                        if (numeroPagine == 42)
                            %if I get up to 42, it means that I have other pages after the 42th
                            
                            urlSplit42 = split(urlAttached34,{'&page=','#page'});
                            %breaking the url again to insert 42
                            
                            urlSplit42{2}='42';
                            %replace 42 within the url
                            
                            urlAttached42 = strjoin(urlSplit42,{'&page=','#page'});
                            %re-attaching the url
                            
                            S42 = webread(urlAttached42);
                            %reading the url
                            
                            pattern42 = ' <ul class="list paginate"><li><a(.*?)</a></li></ul>';
                            %taking everything in between with (.*?)
                            
                            URLnumero42 = regexp(S42, pattern42,'match');
                            %creating an array with all the urls
                            
                            arrayNumeri42 = split(URLnumero42(1),{'#page">','</a></li>'});
                            numeroChar42 = arrayNumeri42{length(arrayNumeri42)-2};
                            numeroPagine = str2double(numeroChar42);
                            
                            if isnan(numeroPagine) %control
                                arrayNumeri42 = split(URLnumero42(1),{'page=','#page"'});
                                numeroChar42 = arrayNumeri42{length(arrayNumeri42)-1};
                                numeroPagine = str2double(numeroChar42);
                            end
                            
                            if (numeroPagine == 50)
                                %if I get up to 50, it means that I have
                                %other pages after the 50th (50 is the maximum)
                                
                                urlSplit50 = split(urlAttached42,{'&page=','#page'});
                                %breaking the url again to insert 50
                                
                                urlSplit50{2}='50';
                                %replace 42 within the url
                                
                                urlAttached50 = strjoin(urlSplit50,{'&page=','#page'});
                                %re-attaching the url
                                
                                S50 = webread(urlAttached50);
                                %reading the url
                                
                                pattern50 = ' <ul class="list paginate"><li><a(.*?)</a></li></ul>';
                                %taking everything in between with (.*?)
                                
                                URLnumero50 = regexp(S50, pattern50,'match');
                                %creating an array with all the urls
                                
                                arrayNumeri50 = split(URLnumero50(1),{'#page">','</a></li>'});
                                numeroChar50 = arrayNumeri50{length(arrayNumeri50)-2};
                                numeroPagine = str2double(numeroChar50);
                                
                                if isnan(numeroPagine) %control
                                    arrayNumeri50 = split(URLnumero50(1),{'page=','#page"'});
                                    numeroChar50 = arrayNumeri50{length(arrayNumeri50)-1};
                                    numeroPagine = str2double(numeroChar50);
                                end
                                
                            end
                        end
                    end
                end
            end
        end
        
        
        
        for j = 1:numeroPagine
            
            urlSplitNumeri = split(urlAttached,{'&page=','#page'});
            %breaking the url to go to enter numbers in a progressive manner with 'for' loop
            
            urlSplitNumeri{2}=num2str(j);
            %replacing the page number, converting it from a string to a number
            
            urlAttached2 = strjoin(urlSplitNumeri,{'&page=','#page'});
            %re-attaching the url
            
            options = weboptions('Timeout',60);
            S = webread(urlAttached2,options);
            %reading the url
            
            pattern = '<li><a href="https://itunes.apple.com/us/app/(.*?)</a> </li>';
            %taking everything in between with (.*?)
            
            URLapps = regexp(S, pattern,'match');
            %creating an array with all the urls
            
            for k=1:length(URLapps)
                %building the dataset that includes URL, ID and app name
                
                splitURL = split(URLapps(k),{'/id','?mt=8">','<'});
                canc1 = '<li><a href="';
                canc2 = '</a> </li>';
                URL = regexprep(URLapps(k),canc1,'');
                URL = regexprep(URL,canc2,'');
                Dataset(1,end+1) = URL;                 %url
                
                dimDataset = size(Dataset);
                
                Dataset(2,dimDataset(2)) = splitURL(5); %ID
                
                Dataset(3,dimDataset(2)) = splitURL(4); %name
                
            end
        end
    end
    
    if a == 1
        DatasetA = Dataset';
    end
    
    if a == 2
        DatasetB = Dataset';
    end
    
    clear Dataset
end

DatasetAtable = cell2table(DatasetA, 'VariableNames',{'URL','Name','ID'});
DatasetBtable = cell2table(DatasetB, 'VariableNames',{'URL','Name','ID'});
DatasetMergedTable = union(DatasetAtable,DatasetBtable,'sorted');

%option: it gives us the ability to export to excel
% fileNameDatasetA = 'datasetA.xlsx'
% writetable(DatasetAtable, fileNameDatasetA);
% winopen(fileNameDatasetA);
clearvars -except DatasetMergedTable DatasetAtable DatasetBtable DatasetA DatasetB
