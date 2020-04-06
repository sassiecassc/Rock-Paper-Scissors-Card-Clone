/// @description Insert description here
// You can write your code in this editor

if(keyboard_check_pressed(vk_enter)){
	room_restart();
}
/*
switch(global.state){
	case global.state_deal_cards:
	//if (wait_timer > 0){
			//do nothing and wait
			//wait_timer -= 1;
		//}
		//else {
			//if (card_timer == 0){
			//THIS IS THE AI'S HAND
			//ONLY DEAL OUT 3 CARDS NOT ALL 24!
				if (ds_list_size(global.deck) > 0) {
					//deal a card from the top of the deck
					//which is the last card in the deck list
					var last_index = ds_list_size(global.deck) -1;
					var topcard = global.deck[| last_index];
			
					//this won't delete the card object from the game
					//it just deletes it from the deck
					ds_list_delete(global.deck, last_index);
			
				///if(global.their_hand < 3){
						//add the card to their hand list
						ds_list_add(global.their_hand, topcard);
					//} else if(ds_list_size(global.their_hand) == 3){
						
					//}
					
			
					//move the sprite to the table
					topcard.target_x = 90 + 44 * ds_list_size(global.their_hand); //90 pix from the left side of screen; 44 pixels apart
					topcard.target_y = 100;
				}
				else {
					//no cards left to deal	
					global.state = global.state_my_select;
				//}
			//}
		}
		break;
	
	
	
	
		break;
	case global.state_my_select:





		break;
	case global.state_wait_for_evaluate:





		break;
	case global.state_evaluate:






		break;
	case global.state_wait_after_evaluate:





		break;
	case global.state_reshuffle:





		break;
}