%%
%initialise imgpath accordingly

%reading image-
%[preimg,row,col]=readImage('D:\galaxian\');
preimg=imread('D:\galaxian\iafbd.jpg');%temp
[row,col,~]=size(preimg);%temp
%display image
imshow(preimg);

%%
R=preimg(:,:,1);        
G=preimg(:,:,2);         
B=preimg(:,:,3); 

%segmenting aliens image
aliens=zeros(row,col);
for i=1:row
	for j=1:col
		if(R(i,j)<100 && G(i,j)>100 && B(i,j)<100)
			aliens(i,j)=1;
		end
	end
end
se=strel('square',5);
io=imopen(aliens,se);
imshowpair(preimg,io,'montage');

[labeledAliens, num_aliens] = bwlabel(aliens);
pos_aliens=regionprops(labeledAliens, 'Centroid');
%%
%outermost loop that terminates only when all the aliens are killed

for n=1:num_aliens
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

	%fix target
	target=1	%sample target
	tdist=pos_alien(1).Centroid(1)-bot_x;
	tdist=sqrt(tdist*tdist);
	for i=2:num_alien
		dist=pos_alien(i).Centroid(1)-bot_x;
		dist=sqrt(dist*dist);
		if(dist<tdist)	%target is the alien closest to bot horizontally
			target=i;
			tdist=dist;
		end
	end	
	%target fixed: "i"
	
	%loop to kill one alien(the current target)
	killed = 0;
	%while killed<1 %infinite loop unless image is provided
		%if checkk sends allclear signal,
			%move bot to the column of the target
			%follow target around, checking for allclear signal before making a move till target is kiled. make killed = 1;
		%if allclear signal not sent, wait
		
	%end
	%end of loop to kill target
end
%end of outermost loop
