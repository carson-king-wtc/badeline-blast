 /// @description Insert description here
// You can write your code in this editor

var datatype = async_load[? "type"]

switch(datatype)
{
	case network_type_connect:
		var player_socket = async_load[? "socket"]
		ds_list_add(total_players,player_socket)
	break;
	
	case network_type_disconnect:
		var disconnect_socket = async_load[? "socket"]
		ds_list_delete(total_players,ds_list_find_index(total_players,disconnect_socket))
	break;
	
	case network_type_data:
		server_data();
	break;
}