%% Full Visual Navigation Algorithm
% Performs correct Dead Reckoning and Balloon Detection
%% Preparation
close all
clear all
clc

%% load calibration parameters
load('MyParams.mat');
cameraParams = MyParams;

%% Parameters
numberOfStrongest = 100;
counter           = 1;
counter2          = 1;
x                 = 0;
y                 = 0;
ynew              = 0;
rotation          = 0;
x_diff            = [];
y_diff            = [];
all_diff          = [];
counter3          = 1;
ynew2             = [];
global tracker;

%% Read Video
v = VideoReader('balloons.mp4');
figure,
%% Start the visual Navigation Algorithm
for i=5:5:4775
    % Dead Reckoning Part
    currentIm           = im2double(read(v,i));
    [currentIm_cal, ~]  = undistortImage(currentIm,cameraParams);
    [distance, theta]   = DeadReckoning(v, currentIm_cal, numberOfStrongest,cameraParams);
    distance(counter)   = distance;
    rotation(counter+1) = rotation(counter) + theta; % Get current orientation
    x(counter+1)        = x(counter) + cos(rotation(counter))*distance(counter);% calculate total distance in x
    y(counter+1)        = y(counter) + sin(rotation(counter))*distance(counter); % Calculate total distance in y
    dy = y(counter+1) - y(counter);
    % Balloon Detection
    [mean_x, mean_y]     = BalloonDetection(currentIm_cal, x, y, rotation, counter);
    
    x_diff{counter2} = (mean_x);
    y_diff(counter2) = (mean_y);
    %all_diff(counter2,:) = [mean(x_diff{counter2}), mean(y_diff{counter2})];
    counter2 = counter2 + 1;
    idx = find(y_diff ~=0, 1, 'first');
    if isempty(idx)
        idx = 1;
    end
    ynew =  ynew + dy -  0.2 * y_diff(idx);
    
    ynew2 = [ynew2 ynew];
    counter = counter + 1;
end
x2=x(1:length(ynew2));
plot(x,y,'r',x2,ynew2,'b')

