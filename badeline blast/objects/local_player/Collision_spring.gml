/// @description Insert description here
// You can write your code in this editor
hsp=lengthdir_x(dashspeed,other.dir)
if(other.dir==90)
{
	vsp=lengthdir_y(dashspeed*1.5,other.dir)
}
else if(other.dir==190)
{
	vsp=lengthdir_y(dashspeed*1.5,other.dir)
}
else
{
	vsp=-dashspeed
}
audio_play_sound(sndspring,1000,false)
i=-5
other.alarm[0]=60
other.image_index=1
candash=true