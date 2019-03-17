%LAB3.2 ASCII conversion and cleaning for empty rows

fine=size(dataset,1);
%find the number of rows
for i=(1:fine)
    
    %using this "for" cicle to delete the elements of the database which are
    %empty, because they caused errors in the first parts of the code
    try
        EnglishTrue = strfind(dataset{i,3},'http');
    catch
        if i<=fine
            dataset(i,:)=[];
            fine=fine-1;
            i=i-1;
        else
            break
        end
    end
    %trying to find if the row has an url in the "url" variable. If it is
    %empty, an error will occur, and the code will then delete the whole
    %row
    
end

fine=size(dataset,1);

for i=(1:fine)
    
    %using this cicle to convert every string in the description field into
    %an array of bytes. Since Matlab encodes every string in Unicode, we
    %know that the first 127 elements are the ones corresponding to the
    %7-bit ASCII.
    descr=dataset{i,4};
    descr=string(descr);
    descr=char(descr);
    str=unicode2native(descr);
    j=1;
    while j<=numel(str)
        if ((str(1,j)>127)||(str(1,j)==26))
            %also deleting the element 26 because it is the "substitute"
            %element, and created a lot of unpleasant text with long void
            %spaces without bringing any usable information"
            str(:,j)=[];
            j=j-1;
        end
        j=j+1;
    end
    str=native2unicode(str,'US-ASCII');
    descr=string(str);
    descr=cellstr(descr);
    dataset{i,4}=descr;
    %doing the conversion again in the opposite way, converting in
    %ASCII and putting it back in the database
    
end