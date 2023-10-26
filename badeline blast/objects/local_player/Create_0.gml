/// @description Insert description here
// You can write your code in this editor
hsp=0 //the horizontal speed of the player
vsp=0 //the vertical speed of the player
msp=7 //the movement speed of the player
jsp=15 //the jump speed of the player
grav=1 //the gravity of the player
fric=0.9 //the friction of the player
candash=true //whether the player can dash
dashspeed=15
dsp=[0,0]
name=get_string("enter name:","madeline")
image_xscaley=1
dashlength=9

randomize()
var choice = irandom_range(1, 10000)
my_id=choice

hp=100
mhp=100
i=-5
i2=0
function reset()
{
	hp-=10
	if(hp>0)
	{
		x=xstart
		y=ystart
		hsp=0 //the horizontal speed of the player
		vsp=0 //the vertical speed of the player
		msp=7 //the movement speed of the player
		jsp=15 //the jump speed of the player
		grav=1 //the gravity of the player
		fric=0.9 //the friction of the player
		candash=true //whether the player can dash
		dashspeed=15
		dsp=[0,0]
		image_xscaley=1
		dashlength=9

		i=-5
		i2=0
	}
}