/// @description Insert description here
// You can write your code in this editor

if(find_winner()!=false)
{
	draw_text(camera_get_view_width(view_camera[0])/2,camera_get_view_height(view_camera[0])/2,find_winner())
	if(alarm[0]<0)
	{
		alarm[0]=360
	}
}