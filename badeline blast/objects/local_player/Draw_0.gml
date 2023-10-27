/// @description Insert description here
// You can write your code in this editor
if(hp>0)
{
	var coll=c_aqua
	if(framesSinceLastDash<=dashlength*0.75&&framesSinceLastDash>0&&!amountOfDashesLeft)
	{
		coll=c_white
	}
	if(amountOfDashesLeft==1)
	{
		coll=c_red
	}
	if(amountOfDashesLeft==2)
	{
		coll=make_color_rgb(255,192,203)
	}
	if(hsp!=0)
	{
		image_xscaley=sign(hsp)
	}
	var xscale=image_xscaley
	var rot=0
	if(framesSinceLastDash>-5)
	{
		rot=point_direction(x,y,x+dsp[0],y+dsp[1])
	}
	var yscale=1
	if(rot>=180)
	{
		yscale=-1
		xscale=1
	}
	if(sprite_index!=playersprdash)
	{
		draw_sprite_ext(sprite_index,image_index,x,y,xscale,yscale,rot,c_white,1)
		draw_sprite_ext(hair,image_index,x,y,image_xscaley,1,0,coll,1)
	}
	else
	{
		draw_sprite_ext(sprite_index,image_index,x,y,1,1,rot,c_white,1)
	}
	draw_set_color(c_red)
	draw_rectangle(x-64*(hp/mhp),y-96,x+64*(hp/mhp),y-64,false)
	draw_set_color(c_lime)
	if(stamina>0)
	{
		draw_rectangle(x-64*(stamina/maxstamina),y-128-32,x+64*(stamina/maxstamina),y-96-32,false)
	}
	draw_set_color(c_white)
	draw_text(x,y-128,name)
}
else
{
	draw_sprite(grave,0,x,y)
}