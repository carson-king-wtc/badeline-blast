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
dashspeed=15//the speed the player dashes at
dsp=[0,0]//the dash velocity of the player
name=get_string("enter name:","madeline")//get the player's name
image_xscaley=1
dashlength=9
maxdashes=1

stamina=320//stamina for the player's climbing
maxstamina=320

randomize()
var choice = irandom_range(1, 10000)//set the player's id for the client and hope and pray it isnt the same as another player's
my_id=choice

hp=100//player's hp
mhp=100//player's max hp
framesSinceLastDash=-5
techFramesLeft=0
immunityFrames=90
coyoteFramesLeft=0

//respawn the player at a random position
function spawn()
{
	x=irandom(room_width)
	y=irandom(room_height)
	// if the player is inside a wall, inside another player, or not above a wall, change their position again.
	while(place_meeting(x,y,player_buffer)||place_meeting(x,y,wall)||!collision_line(x,bbox_bottom,x,room_height,wall,true,true))
	{
		x=irandom(room_width)
		y=irandom(room_height)
	}
}

//if the player is on the floor, return true, otherwise return false
function isOnFloor(){
return place_meeting(x,y+1,wall)
}

//function for acceleration
function moveToward(from,to,by){
	
	if (abs(from-to) < by) {
		return to
	}
	
	if (from < to) {
		return from + by
	}
	
	return from - by
	
}

//this function kills the player if they have no immunity frames. 
function reset()
{
	if(immunityFrames<=0)
	{
		hp-=10
		if(hp>0) //when player is alive
		{
			spawn()
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
			immunityFrames=120
		}
		else //when player is now dead
		{
			//add player's name to the leaderboard
			array_push(Client.leaderboard,name)
			//make sure their name isnt added again until next round
			immunityFrames=9999999999999
		}
	}
}