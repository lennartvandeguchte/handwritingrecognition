%%
cd('..');
cd('dataset');
cd('Train');

imageFiles = dir('*.pgm');
nSentences = length(imageFiles);

labelFiles = dir('*.xml');
nLabels = length(labelFiles);

j=1;
for i=1:3 %%% aanpassen in nSentences voor alle data
   currentFileName = imageFiles(i).name;
   currentImage = imread(currentFileName);
   
   currentLabelName = labelFiles(i).name;
   currentLabel = fopen(currentLabelName);
   

    tline = fgetl(currentLabel);
    while ischar(tline)
        disp(tline)
          
        x = str2double(regexp(tline, '(?<=x=)[0-9]+', 'match'));
        y = str2double(regexp(tline, '(?<=y=)[0-9]+', 'match'));
        w = str2double(regexp(tline, '(?<=w=)[0-9]+', 'match'));
        h = str2double(regexp(tline, '(?<=h=)[0-9]+', 'match'));
            
        labels{j} = regexp(tline, '(?<=<txt>)@\w*'  , 'match'); 
        fonts{j} = regexp(tline, '(?<=<utf> )[0-9]+\w*'  , 'match');
        labeledSigns{j} = imcrop(currentImage, [x, y, w, h]);
         
        imshow(labeledSigns{j}); 
        tline = fgetl(currentLabel);
        j = j+1;
    end

    fclose(currentLabel);
   
   %%T = adaptthresh(currentImage, 0.4);
   %%BW = imbinarize(currentImage, T);
   %%imshowpair(currentimage,BW,'montage')
   chineseSentences{i} = currentImage;
end





cd('..');
cd('..');
cd('implementation');