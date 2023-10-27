/// @description Insert description here
// You can write your code in this editor
hsp=0 //the horizontal speed of the player
vsp=0 //the vertical speed of the player
msp=7 //the movement speed of the player
jsp=15 //the jump speed of the player
grav=1 //the gravity of the player
fric=0.9 //the friction of the player
candash=1 //whether the player can dash
dashspeed=15
dsp=[0,0]
name=get_string("enter name:","madeline")
image_xscaley=1
dashlength=9
maxdashes=1


randomize()
var choice = irandom_range(1, 10000)
my_id=choice

hp=100
mhp=100
i=-5
i2=0
i3=90
x=irandom(room_width)
y=irandom(room_height)
while(place_meeting(x,y,player_buffer)||place_meeting(x,y,wall)||!collision_line(x,bbox_bottom,x,room_height,wall,true,true))
{
	x=irandom(room_width)
	y=irandom(room_height)
}
function reset()
{
	if(i3<=0)
	{
		hp-=10
		if(hp>0)
		{
			x=irandom(room_width)
			y=irandom(room_height)
			while(place_meeting(x,y,player_buffer)||place_meeting(x,y,wall)||!collision_line(x,bbox_bottom,x,room_height,wall,true,true))
			{
				x=irandom(room_width)
				y=irandom(room_height)
			}
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
			i3=120
		}
		else
		{
			array_push(Client.leaderboard,name)
		}
	}
}