/// @description Insert description here
// You can write your code in this editor
/// @description Recieve Incoming Data

/*
This is the same scenario as the server, more or less. Here we simply do the same as the server, and get the incoming buffer packet
Then, we can read this data and assign it to whoever we need to

See more below
*/

var packet = async_load[? "buffer"];
buffer_seek(packet, buffer_seek_start, 0);

var PACKET_ID = buffer_read(packet, buffer_u8);

switch (PACKET_ID) {

	#region Movement
	case network.move:	//If we get the packet for movement, assign it to the correct player
		var player_idd = buffer_read(packet, buffer_u16);
		var find_player = ds_map_find_value(instances, player_idd);		//Find the instance ID of the player through the instance map
		
		//If there is no player with that ID in our map, then create one and add it to the map
		if (is_undefined(find_player)) {
			var p = instance_create_layer(random(room_width), room_height/2, "Instances", player_buffer);
			p.my_id=player_idd
			ds_map_add(instances, player_idd, p);
		} else {	//If the player IS in the instance map, then assign them the data if their ID matches the packet's
			if (idd != player_idd) && (instance_exists(find_player)) {
				//Read the rest of the data from the packet
				var player_x = buffer_read(packet, buffer_s16);
				var player_y = buffer_read(packet, buffer_s16);
				var amountOfDashesLeft = buffer_read(packet, buffer_s16);
				var hp = buffer_read(packet, buffer_s16);
				var name = buffer_read(packet, buffer_string);
				
				//Assign this data to the correct player
				find_player.x = player_x;
				find_player.y = player_y;
				find_player.amountOfDashesLeft = amountOfDashesLeft;
				find_player.hp = hp;
				find_player.name = name;
			}
		}
	break;
	#endregion
	
	/*#region Shooting
	case network.shoot:
		//When we get the packet of someone shooting, we need to read the data and perform a few actions
		//First we need to get the bullet's ID before anything
		var bullet_id = buffer_read(packet, buffer_u16);
		
		//Then we check to see if we shot the bullet or not
		if (idd != bullet_id) {
			//If we didn't shoot the bullet, we can continue reading and assigning the data
			var bullet_x = buffer_read(packet, buffer_s16);
			var bullet_y = buffer_read(packet, buffer_s16);
			var bullet_direction = buffer_read(packet, buffer_s16);
			
			//Now we create an instance of that bullet, and assign the data we just read
			var new_bullet = instance_create_layer(bullet_x, bullet_y, "Instances", oBullet);
			new_bullet.my_id = bullet_id;
			new_bullet.direction = bullet_direction;
		}
	break;
	#endregion*/

}
