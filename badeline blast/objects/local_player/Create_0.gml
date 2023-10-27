/// @description Insert description here
// You can write your code in this editor
hsp=0 //the horizontal speed of the player
vsp=0 //the vertical speed of the player
msp=7 //the movement speed of the player
jumpForce=-15 //the jump speed of the player
minJumpForce = -5

//doing msp/ number of frames we want it to take to reach the target speed.
ACCEL= msp/6
AIRACCEL=msp/12
DECCEL=msp/4
AIRDECCEL=msp/8
AIRACCELNATURAL=msp/240

grav=1 //the gravity of the player
maxFallSpeed = 20
fric=0.9 //the friction of the player
amountOfDashesLeft=1 //whether the player can dash
dashspeed=15
dsp=[0,0]
name=get_string("enter name:","madeline")
image_xscaley=1
dashlength=9
maxdashes=1

stamina=320
maxstamina=320

randomize()
var choice = irandom_range(1, 10000)
my_id=choice

hp=100
mhp=100
framesSinceLastDash=-5
techFramesLeft=0
i3=90
coyoteFramesLeft=0
x=irandom(room_width)
y=irandom(room_height)
while(place_meeting(x,y,player_buffer)||place_meeting(x,y,wall)||!collision_line(x,bbox_bottom,x,room_height,wall,true,true))
{
	x=irandom(room_width)
	y=irandom(room_height)
}

function isOnFloor(){
return place_meeting(x,y+1,wall)
}

function moveToward(from,to,by){
	
	if (abs(from-to) < by) {
		return to
	}
	
	if (from < to) {
		return from + by
	}
	
	return from - by
	
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
			amountOfDashesLeft=1 //whether the player can dash
			dashspeed=15
			dsp=[0,0]
			image_xscaley=1
			dashlength=9

			framesSinceLastDash=-5
			techFramesLeft=0
			i3=120
		}
		else
		{
			array_push(Client.leaderboard,name)
		}
	}
}