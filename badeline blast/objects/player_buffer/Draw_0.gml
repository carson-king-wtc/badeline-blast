/// @description Insert description here
// You can write your code in this editor
var coll=c_blue
if(candash)
{
	coll=c_red
}
draw_sprite_ext(sprite_index,0,x,y,1,1,0,coll,1)
draw_set_color(c_red)
draw_rectangle(x-64,y-96,x+64*(hp/mhp),y-64,false)
draw_set_color(c_white)
draw_text(x,y-128,name)