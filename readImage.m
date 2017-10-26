function [preimg,row,col]=readImage(imgpath)
	imglist = dir(imgpath);
	[imgcount , ~] = size(imglist);
	imgfile = imglist(imgcount);
	imgname= imgfile.name;
	preimg=imread(strcat(imgpath,imgname));
	[row,col,~]=size(preimg);
end
