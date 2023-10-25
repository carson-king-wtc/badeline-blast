/// @description Insert description here
// You can write your code in this editor

if(instance_exists(Client&&my_id==Client.idd))
{
	var lasti=i
	i--
	var lkey=keyboard_check(vk_left)||keyboard_check(ord("A"))||gamepad_button_check(0,gp_padl)||gamepad_axis_value(0, gp_axislh)<0
	var rkey=keyboard_check(vk_right)||keyboard_check(ord("D"))||gamepad_button_check(0,gp_padr)||gamepad_axis_value(0, gp_axislh)>0
	var ukey=keyboard_check(vk_up)||keyboard_check(ord("W"))||gamepad_button_check(0,gp_padu)||gamepad_axis_value(0, gp_axislv)<0
	var dkey=keyboard_check(vk_down)||keyboard_check(ord("S"))||gamepad_button_check(0,gp_padd)||gamepad_axis_value(0, gp_axislv)>0
	var jkey=keyboard_check_pressed(vk_space)||gamepad_button_check_pressed(0,gp_face1)
	var dashkey=keyboard_check_pressed(vk_shift)||gamepad_button_check_pressed(0,gp_face3)
	if(dashkey&&candash)
	{
		vsp=(dkey-ukey)*dashspeed
		hsp=(rkey-lkey)*dashspeed
		dsp=[hsp,vsp]
		i=10
		candash=false
	}
	if(i>0)
	{
		hsp=dsp[0]
		vsp=dsp[1]
		if(place_meeting(x,y+1,wall)&&jkey)
		{
			//show_message("")
			i=0
			vsp=-jsp
			hsp=dsp[0]
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
	if(i<=0)
	{
		if(hsp*(rkey-lkey)<msp)
		{
			hsp+=(rkey-lkey)*msp/3
		}
		if(abs(hsp)>msp||!place_meeting(x,y+1,wall))
		{
			fric=0.8
		}
		else
		{
			fric=0.5
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
			if(jkey)
			{
				vsp=-jsp
			}
			candash=true
		}
		vsp+=grav
	}
	col=instance_place(x+hsp,y,wall)
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