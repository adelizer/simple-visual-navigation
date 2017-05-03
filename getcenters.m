function [ centers,radii ] = getcenters( im, h )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %figure;imshow(im,[]);
    %BW = edge(img_hsv(:,:,2),'Canny');
    im_hsv = rgb2hsv(im);
    im_s = im_hsv(:,:,2);
    im_s = imfilter(im_s,h);
    [centers,radii] = imfindcircles(im_s,[20,50],'ObjectPolarity','bright', 'Method', 'TwoStage', 'Sensitivity', 0.55);


end

