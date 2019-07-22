function [course, course1] = plotCourse(arenaName, wallClr)
course = rgb2gray(imread(arenaName,'png'));
course = flipud(course);
course = imresize(course, [600 840]);
% ------------------------------------------------------------------------
% Erosion
se=strel('disk',wallClr);
course1 = imerode(~(bwareaopen(~im2bw(course,74/255),120)),se);