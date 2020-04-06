/// @description Insert description here
// You can write your code in this editor

if(keyboard_check_pressed(vk_enter)){
	room_restart();
}

//so you see each card being dealt out one by one
card_timer += 1;
if (card_timer == 10) {
	card_timer = 0;
}

//finite state machine !
switch(global.state){
	case global.state_deal_cards:
	//if (wait_timer > 0){
			//do nothing and wait
			//wait_timer -= 1;
		//}
		//else {
			if (card_timer == 0){
			//THIS IS THE AI'S HAND
			//ONLY DEAL OUT 3 CARDS NOT ALL 24!
				if(ds_list_size(global.their_hand) < 3){
					if (ds_list_size(global.deck) > 0) {
						//deal a card from the top of the deck
						//which is the last card in the deck list
						var last_index = ds_list_size(global.deck) -1;
						var topcard = global.deck[| last_index];
			
						//this won't delete the card object from the game
						//it just deletes it from the deck
						ds_list_delete(global.deck, last_index);
			
						//should only add 3 cards to their_hand list
						ds_list_add(global.their_hand, topcard);
				
						//move the sprite to the table
						topcard.target_x = 90 + 54 * ds_list_size(global.their_hand); //90 pix from the left side of screen; 44 pixels apart
						topcard.target_y = 100;
					}
				} else if(ds_list_size(global.my_hand) < 3){
					if (ds_list_size(global.deck) > 0) {
						show_debug_message(ds_list_size(global.my_hand));
						//deal a card from the top of the deck
						//which is the last card in the deck list
						var last_index = ds_list_size(global.deck) -1;
						var topcard = global.deck[| last_index];
			
						//this won't delete the card object from the game
						//it just deletes it from the deck
						ds_list_delete(global.deck, last_index);
			
						//should only add 3 cards to their_hand list
						ds_list_add(global.my_hand, topcard);
				
						//move the sprite to the table
						topcard.target_x = 90 + 54 * ds_list_size(global.my_hand); //90 pix from the left side of screen; 44 pixels apart
						topcard.target_y = 300;
						
						//flip my hand cards up
						topcard.face_up = true;
					}
				}
				
				else {
					//no cards left to deal	
					global.state = global.state_they_select;
				}
			//}
		}
		break;
	case global.state_they_select:
		if(before_they_select_timer > 0){
			before_they_select_timer -= 1;
		} else if(before_they_select_timer = 0){
			//the opponent randomly chooses their card
			var random_index = choose(0, 1, 2);
			//get the item that's actually at that index
			var chosen_card = ds_list_find_value(global.their_hand, random_index);
			//moving chosen card to center to play
			chosen_card.target_x = 200;
			chosen_card.target_y = 200;
			
			before_they_select_timer = 20;
			global.state = global.state_my_select;
		}
	
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