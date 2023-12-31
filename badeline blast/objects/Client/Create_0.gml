/// @description Insert description here
// You can write your code in this editor

leaderboard=[]

port=get_integer("port:",7676)
ip = get_string("ip adress:","10.99.3.48")

alarm[0]=360

network_set_config(network_config_connect_timeout, 3000)
client = network_create_socket(network_socket_tcp)
network_connect(client,ip,port)

audio_play_sound(music,1000,true)

instances=ds_map_create()
idd=0
Player = instance_create_layer(room_width/2,room_height/2,"Instances",local_player)
idd= Player.my_id

ds_map_add(instances, idd, Player)

if(client < 0)
{
	show_message("error connecting to server")
	game_restart()
}
function find_winner()
{
	var alive=instance_number(player_buffer)+1
	var alive_players=[]
	var i=0
	if(local_player.hp<=0)
	{
		alive-=1
	}
	else
	{
		array_push(alive_players,local_player.id)
	}
	if(instance_number(player_buffer)<=0)
	{
		return "only one player!"
	}
	repeat(instance_number(player_buffer))
	{
		if(instance_find(player_buffer,i).hp<=0)
		{
			alive-=1
		}
		else
		{
			array_push(alive_players,instance_find(player_buffer,i))
		}
	}
	if(alive==0)
	{
		return "tie"
	}
	if(alive==1)
	{
		return "winner: "+alive_players[0].name
	}
	if(alive>1)
	{
		return false
	}
}