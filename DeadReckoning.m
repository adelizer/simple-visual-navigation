function [ distance, theta ] = DeadReckoning( v, currentIm, numberOfStrongest,cameraParams)
% Performs the dead reckoning over the sent video
%   Detailed explanation goes here
persistent prevFeatures prev_ValidPoints call_counter prevIm;

if (isempty(call_counter))
    im = im2double(read(v,1));  %reads frame number 1 from the video
    [prevIm_cal, ~] = undistortImage(im,cameraParams);
    prevIm = rgb2gray(prevIm_cal);
    
    prevPoints = detectSURFFeatures(prevIm);
    [prevFeatures, prev_ValidPoints] = extractFeatures(prevIm,prevPoints.selectStrongest(numberOfStrongest));    
    call_counter = 1;
end

currentIm= rgb2gray(currentIm); 
currentPoints = detectSURFFeatures(currentIm);
[currentFeatures, current_ValidPoints] = extractFeatures(...
    currentIm,currentPoints.selectStrongest(numberOfStrongest));
    
indexPairs = matchFeatures(prevFeatures,currentFeatures);
matchedPoints1 = prev_ValidPoints(indexPairs(:,1),:);
matchedPoints2 = current_ValidPoints(indexPairs(:,2),:);

[tform, inliers1, inliers2] = estimateGeometricTransform(...
    matchedPoints2, matchedPoints1, 'similarity');

% Matrix elements (1,2) and (2,1) are both equal and represent theta
% Element(2,1) is positive for ccw rotation. 
theta = -asin(tform.T(2,1));
Trans = tform.T(3,1:2);
  
distance = sqrt(Trans(1,1)^2 + Trans(1,2)^2);
%rotation(counter+1)  = rotation(counter) + theta; % Get current orientation
%x(counter+1) = x(counter) + cos(rotation(counter))*distance(counter);% calculate total distance in x
%y(counter+1) = y(counter) + sin(rotation(counter))*distance(counter); % Calculate total distance in y
showMatchedFeatures(prevIm,currentIm,inliers1,inliers2);
prevFeatures     = currentFeatures;
prev_ValidPoints = current_ValidPoints;
prevIm = currentIm;

end

