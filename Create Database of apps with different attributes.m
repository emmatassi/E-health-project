%% LAB2

dataset = DatasetMergedTable;
% choose the dataset in input
start = 1;

fine = size(dataset,1);
%define dataset dimensions

numeroRiga = [];
% preallocate a variable  that is needed to delete non-English apps

attributes=['ID','AppName','url','AppDescription','keywords','Version','AgeRating','Language','artistID','artistName','developerURL','Category','price','PriceCurrency','filesize','LastUpdateDate','releaseDate','averageUserRatingForCurrentVersion','userRatingCountForCurrentVersion','AvgUserRatingAll','NumberUserRatingAll','FiveStar','FourStar','ThreeStar','TwoStar','OneStar','DateRetrieved'];

for i = start: fine
    
    try
        url = DatasetMergedTable.URL{i};
        S = webread(url);
        id = DatasetMergedTable.ID{i};
        %use the function webread to obtain information
        
        urllookup = 'https://itunes.apple.com/lookup?id=XXXXX';
        urlSPLIT = split(urllookup,'=');
        urlSPLIT{2} = id;
        urllookup = strjoin(urlSPLIT,'=');
        Slookup = webread(urllookup);
        %for the other informations it's useful to use lookup of iTunes
        
        
        % 1 App ID
        AppID=DatasetMergedTable.ID{i};
        if (isempty(AppID))
            AppID = {'NULL'};
        end
        
        
        % 2 App Name
        AppName=DatasetMergedTable.Name{i};
        if (isempty(AppName))
            AppName = {'NULL'};
        end
        
        
        % 3 URL
        %the URL is already taken considering the URL variable already
        %defined above
        
        
        % 4 App description
        pattern = '<p aria-label="(.*?)" id=';
        AppDescription=regexp(S, pattern, 'tokens');
        if (isempty(AppDescription))
            AppDescription = {'NULL'};
        else
            AppDescription = AppDescription(1);
            AppDescription = string(AppDescription);
        end
        
        
        % 5 Keywords
        pattern = '<meta name="keywords" content="(.*?)" id=';
        Keywords=regexp(S, pattern, 'tokens');
        if (isempty(Keywords))
            Keywords = {'NULL'};
        else
            Keywords = Keywords(1);
            Keywords = string(Keywords);
        end
        
        
        % 6 Version
        pattern = '"versionString":"(.*?)","releaseDate"';
        Version=regexp(S, pattern, 'tokens');
        if (isempty(Version))
            Version = {'NULL'};
        else
            Version = Version(1);
            Version = string(Version);
        end
        
        
        % 7 Age Rating
        pattern = '<dd class="information-list__item__definition l-column medium-9 large-6">Rated (.*?)</dd>';
        AgeRating=regexp(S, pattern, 'tokens');
        if (isempty(AgeRating))
            AgeRating = {'NULL'};
        else
            AgeRating = AgeRating(1);
            AgeRating = string(AgeRating);
        end
        AgeRating = erase(AgeRating,' for the following:');
        
        
        % 8 Language
        pattern = '>Languages</dt>(.*?)" id="ember';
        Language=regexp(S, pattern, 'tokens');
        Language = regexp(Language{1}, '="', 'split');
        Language = Language{1, 1}{1, 2};
        if (isempty(Language))
            datasetNEW.Language = {'NULL'};
        end
        EnglishTrue = strfind(Language,'English');
        if (isempty(EnglishTrue))
            numeroRiga = [numeroRiga i];
        end
        
        
        % 9 Artist ID
        pattern = ':{"data":{"type":"lockup/developer","id":"(.*?)"}}';
        ArtistID=regexp(S, pattern, 'tokens');
        if (isempty(ArtistID))
            ArtistID = {'NULL'};
        else
            ArtistID = ArtistID(1);
            ArtistID = string(ArtistID);
        end
        
        
        % 10 Artist Name
        pattern = '"author":{"@type":"Person","name":"(.*?)",';
        ArtistName=regexp(S, pattern, 'tokens');
        if (isempty(ArtistName))
            ArtistName = {'NULL'};
        else
            ArtistName = ArtistName(1);
            ArtistName = string(ArtistName);
        end
        
        
        % 11 Developer URL
        pattern = '"url":"(.*?)},"';
        DeveloperURL=regexp(S, pattern, 'tokens');
        if (isempty(DeveloperURL))
            DeveloperURL = {'NULL'};
        else
            DeveloperURL = DeveloperURL(1);
            DeveloperURL = string(DeveloperURL);
        end

        
        % 12 Category
        pattern = '"applicationCategory":"(.*?)",';
        Category=regexp(S, pattern, 'tokens');
        if (isempty(Category))
            Category = {'NULL'};
        else
            Category = Category(1);
            Category = string(Category);
        end
        
        
        % 13 Price
        pattern = '"price":(.*?),"priceCu';
        Price=regexp(S, pattern, 'tokens');
        if (isempty(Price))
            Price = {'NULL'};
        else
            Price = Price(1);
            Price = cell2mat([Price{:}]);
            Price = str2double(Price);
        end
        
        
        % 14 Price Currency
        pattern = '"priceCurrency":"(.*?)"';
        PriceCurrency=regexp(S, pattern, 'tokens');
        if (isempty(PriceCurrency))
            PriceCurrency = {'NULL'};
        else
            PriceCurrency = PriceCurrency(1);
            PriceCurrency = string(PriceCurrency);
        end
        
        
        %15 File Size
        pattern = '"fileSizeBytes":"(.*?)",';
        FileSize=regexp(Slookup, pattern, 'tokens');
        if (isempty(FileSize))
            FileSize = {'NULL'};
        else
            FileSize = FileSize(1);
            FileSize = str2double(FileSize{1}); %convert to number
            FileSize = FileSize/1048576; % conversion byte --> Mb
            FileSize = {num2str(FileSize)}; %riconvert in string
        end
        
        
        % 16 Last Update Date
        pattern = '<time data-test-we-datetime datetime="(.*?)" aria-label=';
        LastUpdateDate=regexp(S, pattern, 'tokens');
        if (isempty(LastUpdateDate))
            LastUpdateDate = {'NULL'};
        else
            LastUpdateDate = LastUpdateDate(1);
            LastUpdateDate = string(LastUpdateDate);
            
        end
        
        
        % 17 Release Date
        pattern = '"releaseDate":"(.*?)"';
        ReleaseDate=regexp(S, pattern, 'tokens');
        if (isempty(ReleaseDate))
            ReleaseDate = {'NULL'};
        else
            ReleaseDate = ReleaseDate(1);
            ReleaseDate = string(ReleaseDate);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % The code on "Average User Rating For Current Version" and the one on
        % "User Rating Count For Current Version" is left commented because the
        % rules on the information provided regarding the previous versions of
        % the app have changed on iTunes, for this reason it has not sense to
        % save these attributes.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %     % 18 Average User Rating For Current Version
        %     pattern = '"averageUserRatingForCurrentVersion":(.*?),';
        %     AverageUserRatingForCurrentVersion=regexp(Slookup, pattern, 'tokens');
        %     if (isempty(AverageUserRatingForCurrentVersion))
        %         AverageUserRatingForCurrentVersion = {'NULL'};
        %     else
        %         AverageUserRatingForCurrentVersion = AverageUserRatingForCurrentVersion(1);
        %         AverageUserRatingForCurrentVersion = string(AverageUserRatingForCurrentVersion);
        %     end
        %
        %
        %     % 19 User Rating Count For Current Version
        %     pattern = '"userRatingCountForCurrentVersion":(.*?),';
        %     UserRatingCountForCurrentVersion=regexp(Slookup, pattern, 'tokens');
        %     if (isempty(UserRatingCountForCurrentVersion))
        %         UserRatingCountForCurrentVersion = {'NULL'};
        %     else
        %         UserRatingCountForCurrentVersion = UserRatingCountForCurrentVersion (1);
        %         UserRatingCountForCurrentVersion = string(UserRatingCountForCurrentVersion);
        %     end
        
        
        %20 Average User Rating All
        pattern='"ratingValue":(.*?),"';
        AverageUserRatingAll = regexp(S, pattern, 'tokens');
        if (isempty( AverageUserRatingAll))
            AverageUserRatingAll = {'NULL'};
        else
            AverageUserRatingAll =  AverageUserRatingAll(1);
            AverageUserRatingAll = string(AverageUserRatingAll);
            
        end
        
        
        %21 Number User Rating All
        pattern='"reviewCount":(.*?),}';
        NumberUserRatingAll = regexp(S, pattern, 'tokens');
        if (isempty(NumberUserRatingAll))
            NumberUserRatingAll = {'NULL'};
        else
            NumberUserRatingAll = NumberUserRatingAll(1);
            NumberUserRatingAll = string(NumberUserRatingAll);
        end
        
        
        %22-23-24-25-26 User Rating Stars
        pattern = '<div class="we-star-bar-graph__bar__foreground-bar" style="width:(.*?);' ;
        UserRatingStars = regexp(S, pattern, 'tokens');
        if (isempty(UserRatingStars))
            UserRatingStars = {'NULL','NULL','NULL','NULL','NULL'};
        end
        
        
        %27 Date Retrieved
        DateRetrived = datetime('today');
        DateRetrieved = string(DateRetrived);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        datasetNEW.ID{1,i} = AppID;
        datasetNEW.AppName{1,i} = AppName;
        datasetNEW.url{1,i} = url;
        datasetNEW.AppDescription{1,i} = AppDescription;
        datasetNEW.keywords{1,i} = Keywords; %5
        datasetNEW.Version{1,i} = Version;
        datasetNEW.AgeRating{1,i} = AgeRating;
        datasetNEW.Language{1,i} = Language;
        datasetNEW.artistID{1,i} = ArtistID;
        datasetNEW.artistName{1,i} = ArtistName; %10
        datasetNEW.developerURL{1,i} = DeveloperURL;
        datasetNEW.Category{1,i} = Category;
        datasetNEW.price{1,i} = Price;
        datasetNEW.PriceCurrency{1,i} = PriceCurrency;
        datasetNEW.filesize{1,i} = FileSize; %15
        datasetNEW.LastUpdateDate{1,i} = LastUpdateDate;
        datasetNEW.releaseDate{1,i} = ReleaseDate;
        %datasetNEW.averageUserRatingForCurrentVersion{1,i} = AverageUserRatingForCurrentVersion;
        %datasetNEW.userRatingCountForCurrentVersion{1,i} = UserRatingCountForCurrentVersion;
        datasetNEW.AvgUserRatingAll{1,i} = AverageUserRatingAll; %20
        datasetNEW.NumberUserRatingAll{1,i} = NumberUserRatingAll;
        datasetNEW.FiveStar{1,i} = UserRatingStars{1};
        datasetNEW.FourStar{1,i} = UserRatingStars{2};
        datasetNEW.ThreeStar{1,i} = UserRatingStars{3};
        datasetNEW.TwoStar{1,i} = UserRatingStars{4}; %25
        datasetNEW.OneStar{1,i} = UserRatingStars{5};
        datasetNEW.DateRetrieved{1,i} = DateRetrieved;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    catch
        start = i+1;
    end
end

dataset=structfun(@transpose,datasetNEW,'UniformOutput',false);
dataset=struct2table(dataset);

%Delete apps that do not have the English language
dataset(numeroRiga,:)=[];

clearvars -except DatasetMergedTable dataset datasetNEW
