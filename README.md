# simple-visual-navigation

A MatLAB code to process a video input captured by an upward looking camera on a moving planar robot. Visual odometry is used to create track the pose of the robot, however, it suffers from drift and error accumulation. Therefore, landmarks in the image are extracted which are round-shaped balloons. This is a first step in Visual SLAM where the landmarks can be later on used to correct the robots belief. 

The developed modules are fine-tuned to run on the provided video in the class as this work is done under an image processing course.

Video showing the results: https://www.youtube.com/watch?v=YlHVOwvMMNk