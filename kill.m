killed = 0;
while killed<1
    [preimg,row,col]=readImage('D:\galaxian\');
    %[preimg,row,col]=readImage(imgpath);
    preimg=imread('D:\galaxian\iafbd.jpg');%temp
    [row,col,~]=size(preimg);%temp

	%segmenting aliens image
	alien=zeros(row,col);
	for i=1:row
		for j=1:col
			if(R(i,j)<100 && G(i,j)>100 && B(i,j)<100)
				alien(i,j)=1;
			end
		end
    end
    imshowpair(preimg,alien,'montage');
	[labeledAlien, num_alien] = bwlabel(aliens);
	pos_alien=regionprops(labeledAlien, 'Centroid');
%%
	%segmenting bullets image
	bullets=zeros(row,col);
	for i=1:row
		for j=1:col
			if(R(i,j)>200 && G(i,j)>200 && B(i,j)<50)	%rgb value for yellow: 255,255,0
				bullets(i,j)=1;
			end
		end
    end
    test=imfill(bullets,'holes');
	imshowpair(preimg,test,'montage');

	[labeledBullets, num_bullets] = bwlabel(bullets);
	pos_bullets=regionprops(labeledBullets, 'Centroid');
%%
	%segmenting bot image
	bot_head=zeros(row,col);
	for i=1:row
		for j=1:col
			if(R(i,j)<100 && G(i,j)<100 && B(i,j)>200)
				bot_head(i,j)=1;
			end
		end
    end	
    imshowpair(preimg,bot_head,'montage');

	[labeledBot, num] = bwlabel(bot_head); %label the bot
	pos_bot=regionprops(labeledBot,'Centroid'); %locate the bot
	
    bot_x=pos_bot(1).Centroid(1);
    targ_x=pos_alien(target).Centroid(1);
    