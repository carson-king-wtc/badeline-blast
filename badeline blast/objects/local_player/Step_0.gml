/// @description Insert description here
// You can write your code in this editor
var temporaryhsp=hsp
var temporaryvsp=vsp
var velocity={x:hsp,y:vsp}
if(instance_exists(Client&&my_id==Client.idd))
{

	
	
	if(hp<=30)
	{
		maxdashes=2
	}
	if(y>room_height)
	{
		reset()
	}
	var lastFramesSinceLastDash=framesSinceLastDash
	framesSinceLastDash--
	techFramesLeft--
	i3--
	coyoteFramesLeft--
	if(techFramesLeft>0)
	{
		var pp = part_system_create(techrings)
		part_system_position(pp,x,y)
	}
	gamepad_set_axis_deadzone(0,0.5)
	if(hp>0)
	{
		lkey=keyboard_check(vk_left)||keyboard_check(ord("A"))||gamepad_button_check(0,gp_padl)||gamepad_axis_value(0, gp_axislh)<0
		rkey=keyboard_check(vk_right)||keyboard_check(ord("D"))||gamepad_button_check(0,gp_padr)||gamepad_axis_value(0, gp_axislh)>0
		ukey=keyboard_check(vk_up)||keyboard_check(ord("W"))||gamepad_button_check(0,gp_padu)||gamepad_axis_value(0, gp_axislv)<0
		dkey=keyboard_check(vk_down)||keyboard_check(ord("S"))||gamepad_button_check(0,gp_padd)||gamepad_axis_value(0, gp_axislv)>0
		jkey=keyboard_check(vk_space)||gamepad_button_check(0,gp_face1)||keyboard_check(ord("Z"))
		jkey_just_pressed=keyboard_check_pressed(vk_space)||gamepad_button_check_pressed(0,gp_face1)||keyboard_check_pressed(ord("Z"))
		jkey_just_released=keyboard_check_released(vk_space)||gamepad_button_check_released(0,gp_face1)||keyboard_check_released(ord("Z"))
		dashkey=keyboard_check_pressed(vk_shift)||gamepad_button_check_pressed(0,gp_face3)||keyboard_check_pressed(ord("X"))
		grabkey=keyboard_check(ord("C"))||gamepad_button_check(0,gp_shoulderrb)
	}
	else
	{
		lkey=false
		rkey=false
		ukey=false
		dkey=false
		jkey=false
		dashkey=false
		grabkey=false
	}
	
	//-1 to 1
	var hDirection = (rkey-lkey)
	
	if(dashkey&&amountOfDashesLeft>0)
	{
		audio_play_sound(dashsfx,1000,false)
		vsp=(dkey-ukey)*dashspeed
		hsp=(rkey-lkey)*dashspeed
		if(vsp==0&&hsp==0)
		{
			hsp=dashspeed*image_xscaley
		}
		dsp=[hsp,vsp]
		framesSinceLastDash=dashlength
		amountOfDashesLeft--
	}
	if(framesSinceLastDash>0)
	{
		var pp = part_system_create(dash)
		part_system_position(pp,x,y)
		hsp=dsp[0]
		vsp=dsp[1]
	}
	if(framesSinceLastDash>-5)
	{
		if(place_meeting(x,y+1,wall)&&jkey)
		{
			audio_play_sound(hyper,1000,false)
			//show_message("")
			if(framesSinceLastDash<=dashlength*0.75)
			{
				if(amountOfDashesLeft<maxdashes)
				{
					amountOfDashesLeft=maxdashes
					stamina=maxstamina
				}
			}
			framesSinceLastDash=0
			hsp=(rkey-lkey)*dashspeed
			var pp = part_system_create(jumppart)
			part_system_position(pp,x,bbox_bottom)
			if(dsp[1]>0)
			{
				hsp=(rkey-lkey)*dashspeed*1.2
				vsp=jumpForce*0.75
			}
			else
			{
				vsp=jumpForce
			}
			if(hsp!=0)
			{
				techFramesLeft=30
			}
			coyoteFramesLeft=0
		}
	}
	if(framesSinceLastDash<=0&&lastFramesSinceLastDash>0&&(!place_meeting(x,y+1,wall)||!jkey))
	{
		if(vsp<=0)
		{
			hsp=sign(hsp)*msp
			vsp=sign(vsp)*msp
		}
	}
	if(framesSinceLastDash>-5)
	{
		sprite_change(playersprdash)
	}
	else if(!place_meeting(x,y+1,wall))
	{
		sprite_change(playersprjump)
	}
	else if(abs(hsp)>0.1)
	{
		sprite_change(playersprrun)
	}
	else
	{
		sprite_change(playerspr)
	}
	if(framesSinceLastDash<=0)
	{
		
		
		
		
		//if we are trying to move, accelerate
		if (hDirection != 0){
			if(isOnFloor())
			{
				hsp =  moveToward(hsp,hDirection*msp,ACCEL)
			}
			else
			{
				if(hsp*hDirection>msp)
				{
					hsp =  moveToward(hsp,hDirection*msp,AIRACCELNATURAL)
				}
				else
				{
					hsp =  moveToward(hsp,hDirection*msp,AIRACCEL)
				}
			}
		}
		else{
			if(isOnFloor())
			{
				hsp =  moveToward(hsp,0,DECCEL)
			}
			else
			{
				hsp =  moveToward(hsp,0,AIRDECCEL)
			}
		}
		
		
	
		
		//jumpin boiiii
		
		//we are trying to jump and we were on the floor in the last 10 frames
		if(jkey_just_pressed&&coyoteFramesLeft>0)
		{
			audio_play_sound(jump,1000,false)
			var pp = part_system_create(jumppart)
			part_system_position(pp,x,y)
			
			vsp = jumpForce
		}
		else if (jkey_just_released){
			vsp = max(vsp,minJumpForce)	
			coyoteFramesLeft=0
		}
		
		if(isOnFloor())
		{
			coyoteFramesLeft=10
			
			
			if(lastFramesSinceLastDash<=0)
			{
				if(amountOfDashesLeft<maxdashes)
				{
					amountOfDashesLeft = maxdashes
					stamina=maxstamina
				}
			}
			
			//if we're going down, set the vertical speed to 0
			
		} else{	//we are not on the floor
			//if we're not on the ground or falling faster than terminal velocity, apply gravity
			if(vsp<maxFallSpeed)
			{
				vsp+=grav
			}
		}
		
		
		
	}
	
	if(!isOnFloor())
	{
		var col1=instance_place(x+3+((framesSinceLastDash>-5)*20),y,wall)
		var col2=instance_place(x-3-((framesSinceLastDash>-5)*20),y,wall)
		if(col1||col2)
		{
			if(grabkey&&stamina>0)
			{
				hsp=0
				vsp=0
				vsp=(dkey-ukey)*2
				if(jkey_just_pressed)
				{
					vsp=jumpForce
					stamina-=maxstamina/4
				}
				if(col1)
				{
					x=col1.x-32-abs(x-bbox_right)
				}
				if(col2)
				{
					x=col2.x+32+abs(x-bbox_left)
				}
				stamina--
			}
		}
		if(col1&&hsp>0||col2&&hsp<0)
		{
			if(vsp>0)
			{
				vsp-=grav*0.9
			}
		}
		if(hsp>=0&&col1&&jkey_just_pressed)
		{
			audio_play_sound(climb,1000,false)
			if(hsp==0)
			{
				vsp=jumpForce
				hsp=-msp/2
			}
			else
			{
				vsp=jumpForce/1.5
				hsp=-msp
			}
			if(framesSinceLastDash>-5)
			{
				framesSinceLastDash=0
				vsp=-dashspeed*1.5
				techFramesLeft=30
				hsp=-msp*2
				audio_play_sound(superjump,1000,false)
			}
		}
		if(hsp<=0&&col2&&jkey_just_pressed)
		{
			audio_play_sound(climb,1000,false)
			if(hsp==0)
			{
				vsp=jumpForce
				hsp=msp/2
			}
			else
			{
				vsp=jumpForce/1.5
				hsp=msp
			}
			if(framesSinceLastDash>-5)
			{
				framesSinceLastDash=0
				vsp=-dashspeed*1.5
				techFramesLeft=30
				hsp=msp*2
				audio_play_sound(superjump,1000,false)
			}
		}
	}
	else
	{
		stamina=maxstamina
	}
	var col=instance_place(x+hsp,y,wall)
	if col
	{
		while(!place_meeting(x+sign(hsp),y,wall))
		{
		    x += sign(hsp)
		}
		hsp=0
	}
	x+=hsp

	//vcol
	col=instance_place(x,y+vsp,wall)
	if(col)
	{
		while(!place_meeting(x,y+sign(vsp),wall))
		{
		    y += sign(vsp)
		}
		if (vsp > 0&&amountOfDashesLeft<0){
			audio_play_sound(land,1000,false)
		}
		vsp=0
	}
	y+=vsp
	
	var buff = buffer_create(32,buffer_grow,1)
	buffer_seek(buff,buffer_seek_start,0)
	buffer_write(buff,buffer_u8,network.move)
	buffer_write(buff,buffer_u16,my_id)
	buffer_write(buff,buffer_s16,x)
	buffer_write(buff,buffer_s16,y)
	buffer_write(buff,buffer_s16,amountOfDashesLeft)
	buffer_write(buff,buffer_s16,hp)
	buffer_write(buff,buffer_string,name)
	network_send_packet(Client.client, buff, buffer_tell(buff))
	buffer_delete(buff)
}