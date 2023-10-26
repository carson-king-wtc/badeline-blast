/// @description Insert description here
// You can write your code in this editor
var all_players=ds_list_size(total_players)

draw_set_color(c_white)
draw_set_halign(fa_center)
draw_text(room_width/2,room_height/2,"players connected: "+string(all_players))
draw_text(room_width/2,room_height/2 +64,"type ipconfig in your command prompt to get your ip adress")