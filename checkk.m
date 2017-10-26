function canProceed = checkk(bullet_y, bot_y, allowed)
	if((bot_y-bullet_y)>allowed)
		canProceed=1;
	else
		canProceed=0
	end
end	
