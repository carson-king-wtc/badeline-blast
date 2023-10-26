/// @description Insert description here
// You can write your code in this editor

port=7676
ip = "10.99.3.48"

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