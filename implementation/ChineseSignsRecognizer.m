clear all; 


%%%% Importing Data
disp('Importing data ............');
%importingData  


%%%% Preprocessing


%%%% Segmentation 


%%%% Feature extraction
disp('Feature extraction ............');
cd('..');
cd('dataset');
cd('Chinese-unicode-chars-ChaoMing');
imageFont1 = imread('utf-4e0a.jpg');
cd('..');
cd('Chinese-unicode-chars-CuoKai');
imageFont2 = imread('utf-4e0a.jpg');
cd('..');
cd('..');
cd('implementation');
figure;
size(imageFont1)
imageFont1=rgb2gray(imageFont1);
imageFont2=rgb2gray(imageFont2);

imageFont1 = imbinarize(imageFont1)
imageFont2 = imbinarize(imageFont2)



imageFont1 = bwmorph(imageFont1,'skel',inf)
imageFont2 = bwmorph(imageFont2,'skel',inf)
imshowpair(imageFont1, imageFont2, 'montage');
imageFont1 =discourser(imageFont1);
imageFont2 =discourser(imageFont2);
figure;
imshowpair(imageFont1, imageFont2, 'montage');


labeledSigns = importdata('labeledSigns.mat');
cd('feature extraction');
%feature_extraction(labeledSigns);
%features = feature_extractor_test(labeledSigns{1});

cd('..');

%%%% Classifier