/// @description Insert description here
// You can write your code in this editor









if(!place_meeting(x,y+1,wall))
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


hsp=x-xprevious
vsp=y-yprevious
dsp=[hsp,vsp]