// Handle packets coming from clients

function server_data() {

	var packet = async_load[? "buffer"];		//Load the ID of the buffer that was sent to us
	buffer_seek(packet, buffer_seek_start, 0);  //Make sure we are at start of the incoming packet
	
	var PACKET_ID = buffer_read(packet, buffer_u8); //Read the first value of the packet, which is the network enum
	
	switch (PACKET_ID) {
		
		#region Movement
		case network.move:			//If we recieve the move enum, this event will occur
			var player_idd =			buffer_read(packet, buffer_u16);	//Read the contents of the buffer IN THE ORDER IT WAS SENT
			var player_x =			buffer_read(packet, buffer_s16);
			var player_y =			buffer_read(packet, buffer_s16);
			var amountOfDashesLeft =		buffer_read(packet, buffer_s16);
			var hp =		buffer_read(packet, buffer_s16);
			var name =		buffer_read(packet, buffer_string);
			
			//Now take all those variables, and send them to all of the other clients
			//Send them in the same order they were read above
			var buff = buffer_create(32, buffer_grow, 1);
			buffer_seek(buff, buffer_seek_start, 0);
			buffer_write(buff, buffer_u8, network.move);
			buffer_write(buff, buffer_u16, player_idd);
			buffer_write(buff, buffer_s16, player_x);
			buffer_write(buff, buffer_s16, player_y);
			buffer_write(buff, buffer_s16, amountOfDashesLeft);
			buffer_write(buff, buffer_s16, hp);
			buffer_write(buff, buffer_string, name);
			
			//Loop through the total player list (containing sockets) and send the packet to each one
			for (var i = 0; i < ds_list_size(total_players); i++) {
				network_send_packet(ds_list_find_value(total_players, i), buff, buffer_tell(buff));	
			}
			
			//Delete the buffer after sending the data
			buffer_delete(buff);
		break;
		#endregion
		
		/*#region Shooting
		case network.shoot:
			//Read the data that was sent to us, and store it in temporary variables
			var bullet_idd =			buffer_read(packet, buffer_u16);	//Remember *** Read in the same order it was sent!
			var bullet_x =			buffer_read(packet, buffer_s16);
			var bullet_y =			buffer_read(packet, buffer_s16);
			var bullet_direction =	buffer_read(packet, buffer_s16);
			
			//Now send this data back to all of the clients currently connected to the server
			var bullet_buffer = buffer_create(32, buffer_grow, 1);
			buffer_seek(bullet_buffer, buffer_seek_start, 0);
			buffer_write(bullet_buffer, buffer_u8, network.shoot); //Remember to send the packet ID first!
			buffer_write(bullet_buffer, buffer_u16, bullet_idd);		//Now send in the same order you read the data
			buffer_write(bullet_buffer, buffer_s16, bullet_x);
			buffer_write(bullet_buffer, buffer_s16, bullet_y);
			buffer_write(bullet_buffer, buffer_s16, bullet_direction);
			
			//Loop through the total player list (containing sockets) and send the packet to each one
			for (var i = 0; i < ds_list_size(total_players); i++) {
				network_send_packet(ds_list_find_value(total_players, i), bullet_buffer, buffer_tell(bullet_buffer));	
			}
			
			//Delete the buffer after sending the data
			//buffer_delete(buff);
		break;
		#endregion*/
		
	}

}
