/// @description Insert description here
// You can write your code in this editor
port=7676
max_players=12

server=network_create_server(network_socket_tcp,port,max_players)
total_players = ds_list_create()

if(server<0)
{
	show_message("error creating server!")
	game_restart()
}