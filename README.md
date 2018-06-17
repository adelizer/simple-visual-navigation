# simple-visual-navigation

A MatLAB code to process a video input captured by an upward looking camera on a moving planar robot and estimate the path of the robot. The environment is populated with different balloons that can be used as landmarks.
The current implementation only calculates _visual odometry_ based on the similarity transformation between the _SURF_ features detected between two consecutive frames. This poses a limitation on the estimation accuracy since small errors will accumulate throughout the complete path causing a noticeable drift in the final result. 

Another challenge is to correctly find the location of the landmarks (balloons) with varying brightness conditions. Therefore, HSV color space is used as seen:  

![Alt text](figures/rgb.png?raw=true "RGB image")

![Alt text](figures/hsv.png?raw=true "RGB image")


The developed modules are fine-tuned to run on the provided video in the class. 

The final result:

![Alt text](figures/result.png?raw=true "RGB image")



Video showing the results: https://www.youtube.com/watch?v=YlHVOwvMMNk