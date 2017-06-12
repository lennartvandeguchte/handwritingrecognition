% Before running, make sure your dataset is in ../../dataset/Train/
% Also make sure you have /implementation/segmentation as your working
% directory

%Things still to do:
%  - Whitspace small should check for first char
%  - Check if too big chars are actualy multiple chars at the end. (maybe with the vertical density.)

clear;
dataDir = '../../dataset/Train/';
outputDir = strcat(dataDir,'../Train_segmented/');
mkdir(outputDir);
dirContents = dir(dataDir);

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

for i = 211%3:size(dirContents,1)
    fileName = dirContents(i).name;
    
    if ~all(fileName(end-3:end) == '.pgm')
        continue;
    end
    
    A = imread(strcat(dataDir,fileName));
    
    %------Magic happens here:
    
    %binarize image
    binA = seg_binairy(A);
    
    %rotate image
    [rotatedA,angle] = seg_rotation(binA);

    %crops the image verticaly
    vCroppedA = seg_v_density(rotatedA);
    
    %trims any whitespace from the sides
    trimmedA = seg_trim_image(vCroppedA);

    %gets the connected components
    characters = seg_concomp(trimmedA);

    %frames the components on a canvas
    framed = seg_canvas_comps( characters , trimmedA);

    %finds the outliers: 3 std +/- the mean from the labeled data
    [big,small] = seg_find_outliers(framed, meanWidth, stdWidth);

    %checks if this 'small' char is a standalone char
    small = seg_small_whitespace(small ,characters, trimmedA, meanWidth, stdWidth);

    %find noise components
    noise = seg_find_noise_comps( small, framed );

    nsb = [noise,small,big];

    %removes the noise components
    [characters, nsb] = seg_remove_noise_comps(characters, nsb); 

    %merges small components to their best bet neighbors
    [characters,nsb] = seg_merge_smallest_neigbour( characters, nsb, trimmedA, meanWidth, stdWidth);

    %frames the components on a canvas
    framed = seg_canvas_comps( characters , trimmedA);    
    
    %------Write to file
    imageDir = strcat(outputDir,fileName(1:end-4),'/');
    mkdir(imageDir);
    for j = 1:length(framed)
        I = abs(framed{j}-1);
        imwrite(I,strcat(imageDir,num2str(j),'.png'));
    end
    disp(strcat('finished - ', fileName(1:end-4)));
end