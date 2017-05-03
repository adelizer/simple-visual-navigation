function  rgb  = get_roi( im, centers, w )
% get_roi() function gets the region of interest in the image according to
% the given locations. the w variable is the window size. 
for i = 1:size(centers,1)
    tempx = centers(i,1);
    tempy = centers(i,2);
    window = imcrop(im,[tempx - w, tempy - w, 2*w, 2*w]);
    w_r = mean(mean(window(:,:,1)));
    w_g = mean(mean(window(:,:,2)));
    w_b = mean(mean(window(:,:,3)));
    rgb(i,:) = cat(2,w_r, w_g, w_b);
end

