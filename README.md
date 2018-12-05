# pgm_process
---------- purpose ----------
process pgm file from my another repostery: TableKeyBoard

---------- Main ----------
read main_DEPTHimage.m and main_IRimage.m as two main function
[main_DEPTHimage.m] process depth image. Find plane in image to recognize hand (not good).
[main_IRimage.m]    process IR image. Find edge of hand and recognize fingertip.

---------- other materials ----------
1) how to get raw data of depth camera
   refer to https://github.com/zwz14/TableKeyBoard/README.md
2) how to convert depth data from hololens to real depth
   refer to https://github.com/Microsoft/HoloLensForCV/issues/63 answer of 'Huangying-Zhan'
3) about valid pixels 
   refer to https://github.com/Microsoft/HoloLensForCV/issues/56 answer of 'zwz14'
   (1) ShortThrowToFDepth takes 0.2m(200) to 1.0m(1000) as valid pixels.
   (2) the valid-pixel area is cicle instead of the whole 450×488 area
4) how to recognize fingertip
   refer to article: Vision-Based Finger Action Recognition by Angle Detection and Contour Analysis 
