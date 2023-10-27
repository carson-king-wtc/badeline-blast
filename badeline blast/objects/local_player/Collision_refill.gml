/// @description Insert description here
// You can write your code in this editor




if(amountOfDashesLeft<other.dashes&&other.active)
{
	other.alarm[0]=240
	other.active=false
	amountOfDashesLeft=other.dashes
	audio_play_sound(refilltouchsnd,1000,false)
	var pp = part_system_create(refillpart)
	part_system_position(pp,other.x,other.y)
}