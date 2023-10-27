/// @description Insert description here
// You can write your code in this editor

if(find_winner()!=false)
{
	draw_text(camera_get_view_width(view_camera[0])/2,camera_get_view_height(view_camera[0])/2,find_winner())
	var why=64
	var i=array_length(leaderboard)-1
	var i2=1
	repeat(array_length(leaderboard))
	{
		draw_text(camera_get_view_width(view_camera[0])/2,camera_get_view_height(view_camera[0])/2+why,string(i2)+""+leaderboard[i])
		why+=64
		i--
		i2++
	}
	if(alarm[0]<0)
	{
		alarm[0]=360
	}
}