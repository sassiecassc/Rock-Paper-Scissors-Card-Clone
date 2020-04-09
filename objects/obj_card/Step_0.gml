/// @description Insert description here
// You can write your code in this editor

//The card is responsible for deciding which sprite to draw,
//based on its face_up and card_type variables
if (face_up == false){
	sprite_index = spr_back;
}
else {
	//card is face up	
	if (card_type == global.rock) {
		sprite_index = spr_rock;
	}
	else if (card_type == global.scissor){
		sprite_index = spr_scissor;
	}
	else if (card_type == global.paper){
		sprite_index = spr_paper;	
	}
}

//move 10% of the way to the target x and y, every frame
//creates a smooth move
x = lerp(x, target_x, 0.15);
y = lerp(y, target_y, 0.15);

