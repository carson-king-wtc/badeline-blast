/// @description Insert description here
// You can write your code in this editor
horizontalSpeed=lengthdir_x(dashspeed,other.dir)
if(other.dir==90)
{
	verticalSpeed=lengthdir_y(dashspeed*1.5,other.dir)
}
else if(other.dir==270)
{
	verticalSpeed=lengthdir_y(dashspeed*1.5,other.dir)
}
else
{
	verticalSpeed=-dashspeed
}
audio_play_sound(sndspring,1000,false)
framesSinceLastDash=-5
other.alarm[0]=60
other.image_index=1
amountOfDashesLeft=true