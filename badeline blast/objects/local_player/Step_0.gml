/// @description Insert description here
// You can write your code in this editor

if(instance_exists(Client&&my_id==Client.idd))
{
	var lasti=i
	i--
	i2--
	if(i2>0)
	{
		var pp = part_system_create(techrings)
		part_system_position(pp,x,y)
	}
	gamepad_set_axis_deadzone(0,0.5)
	var lkey=keyboard_check(vk_left)||keyboard_check(ord("A"))||gamepad_button_check(0,gp_padl)||gamepad_axis_value(0, gp_axislh)<0
	var rkey=keyboard_check(vk_right)||keyboard_check(ord("D"))||gamepad_button_check(0,gp_padr)||gamepad_axis_value(0, gp_axislh)>0
	var ukey=keyboard_check(vk_up)||keyboard_check(ord("W"))||gamepad_button_check(0,gp_padu)||gamepad_axis_value(0, gp_axislv)<0
	var dkey=keyboard_check(vk_down)||keyboard_check(ord("S"))||gamepad_button_check(0,gp_padd)||gamepad_axis_value(0, gp_axislv)>0
	var jkey=keyboard_check_pressed(vk_space)||gamepad_button_check_pressed(0,gp_face1)
	var dashkey=keyboard_check_pressed(vk_shift)||gamepad_button_check_pressed(0,gp_face3)
	if(dashkey&&candash)
	{
		audio_play_sound(dashsfx,1000,false)
		vsp=(dkey-ukey)*dashspeed
		hsp=(rkey-lkey)*dashspeed
		if(vsp==0&&hsp==0)
		{
			hsp=dashspeed*image_xscaley
		}
		dsp=[hsp,vsp]
		i=dashlength
		candash=false
	}
	if(i>0)
	{
		var pp = part_system_create(dash)
		part_system_position(pp,x,y)
		hsp=dsp[0]
		vsp=dsp[1]
	}
	if(i>-5)
	{
		if(place_meeting(x,y+1,wall)&&jkey)
		{
			audio_play_sound(hyper,1000,false)
			//show_message("")
			if(i<=dashlength*0.75)
			{
				candash=true
			}
			i=0
			hsp=(rkey-lkey)*dashspeed
			var pp = part_system_create(jumppart)
			part_system_position(pp,x,bbox_bottom)
			if(dsp[1]>0)
			{
				hsp=(rkey-lkey)*dashspeed*1.2
				vsp=-jsp*0.75
			}
			else
			{
				vsp=-jsp
			}
			if(hsp!=0)
			{
				i2=30
			}
		}
	}
	if(i<=0&&lasti>0&&(!place_meeting(x,y+1,wall)||!jkey))
	{
		if(vsp<=0)
		{
			hsp=sign(hsp)*msp
			vsp=sign(vsp)*msp
		}
	}
	if(i>-5)
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
	if(i<=0)
	{
		if(abs(hsp)>msp||!place_meeting(x,y+1,wall))
		{
			fric=0.8
		}
		else
		{
			fric=0.5
		}
		if(hsp*(rkey-lkey)<msp)
		{
			if(fric==0.8)
			{
				hsp+=(rkey-lkey)*msp/12
			}
			else
			{
				hsp+=(rkey-lkey)*msp/3
			}
		}
		if(!lkey&&!rkey||abs(hsp)>msp&&place_meeting(x,y+1,wall)&&lasti<=0)
		{
			hsp*=fric
			if(abs(hsp-round(hsp))<=0.1)
			{
				hsp=round(hsp)
			}
		}
		if(place_meeting(x,y+1,wall))
		{
			if(vsp!=0)
			{
				audio_play_sound(land,1000,false)
			}
			if(jkey)
			{
				audio_play_sound(jump,1000,false)
				vsp=-jsp
				var pp = part_system_create(jumppart)
				part_system_position(pp,x,y)
			}
			if(lasti<=0)
			{
				candash=true
			}
		}
		else
		{
			vsp+=grav
		}
	}
	if(!place_meeting(x,y+1,wall))
	{
		var col1=instance_place(x+3+((i>-5)*20),y,wall)
		var col2=instance_place(x-3-((i>-5)*20),y,wall)
		if(col1&&hsp>0||col2&&hsp<0)
		{
			if(vsp>0)
			{
				vsp-=grav*0.9
			}
		}
		if(hsp>=0&&col1&&jkey)
		{
			audio_play_sound(climb,1000,false)
			if(hsp==0)
			{
				vsp=-jsp
				hsp=-msp/2
			}
			else
			{
				vsp=-jsp/1.5
				hsp=-msp
			}
			if(i>-5)
			{
				i=0
				vsp=-dashspeed*1.5
				i2=30
				hsp=-msp*2
				audio_play_sound(superjump,1000,false)
			}
		}
		if(hsp<=0&&col2&&jkey)
		{
			audio_play_sound(climb,1000,false)
			if(hsp==0)
			{
				vsp=-jsp
				hsp=msp/2
			}
			else
			{
				vsp=-jsp/1.5
				hsp=msp
			}
			if(i>-5)
			{
				i=0
				vsp=-dashspeed*1.5
				i2=30
				hsp=msp*2
				audio_play_sound(superjump,1000,false)
			}
		}
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
		vsp=0
	}
	y+=vsp
	
	var buff = buffer_create(32,buffer_grow,1)
	buffer_seek(buff,buffer_seek_start,0)
	buffer_write(buff,buffer_u8,network.move)
	buffer_write(buff,buffer_u16,my_id)
	buffer_write(buff,buffer_s16,x)
	buffer_write(buff,buffer_s16,y)
	buffer_write(buff,buffer_s16,candash)
	buffer_write(buff,buffer_s16,hp)
	buffer_write(buff,buffer_string,name)
	network_send_packet(Client.client, buff, buffer_tell(buff))
	buffer_delete(buff)
}