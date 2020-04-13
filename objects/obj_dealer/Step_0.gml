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
						audio_play_sound(snd_deal_cards, 1, 0);
						
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
						topcard.target_x = 120 + 70 * ds_list_size(global.their_hand); //90 pix from the left side of screen; 44 pixels apart
						topcard.target_y = 30;
					}
				} else if(ds_list_size(global.my_hand) < 3){
					if (ds_list_size(global.deck) > 0) {
						audio_play_sound(snd_deal_cards, 1, 0);
						
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
						topcard.target_x = 120 + 70 * ds_list_size(global.my_hand); //90 pix from the left side of screen; 44 pixels apart
						topcard.target_y = 280;
						
						//flip my hand cards up
						//ADD TIMER HERE SO IT DOESN'T FACE UP RIGHT AWAY
						//timer counts down
						//if(faceup_timer > 0){
						//	show_debug_message("counting down" + string(faceup_timer));
						//	faceup_timer -= 1;
						//} else if(faceup_timer = 0){
							topcard.face_up = true;
						//}
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
			audio_play_sound(snd_deal_cards, 1, 0);
			//the opponent randomly chooses their card
			var random_index = choose(0, 1, 2);
			//get the item that's actually at that index
			var chosen_card = ds_list_find_value(global.their_hand, random_index);
			//global.their_hand[| random_index];
			opponent_chosen_index = random_index;
			//moving chosen card to center to play
			chosen_card.target_x = 260;
			chosen_card.target_y = 115;
			
			before_they_select_timer = 20;
			global.state = global.state_my_select;
		}
	
		break;
	case global.state_my_select:
	//did the player click the mouse button
	//if the player clicked the mouse button then
	//check to see if they clicked on a card
	//if they clicked on a card then
	//bring it up and play that card
	//if they did not click the mouse button then
	//check to see if they are colliding with a card
	//if they are colliding with a card then
	//do the hover effect and lerp a bit up
	//check to see if player is over card
	//CANT SELECT BEFORE THE OPPONENT SELECTS
	
		//check to see if the cards are at the normal y position
		for (i=0; i<ds_list_size(global.my_hand); i++){
			var thiscard = global.my_hand[| i];
			thiscard.target_y = 280; 
		}
	
	
		var mouse_over_card = instance_position(mouse_x, mouse_y, obj_card);
		//there is collision with mouse and card
		if (mouse_over_card != noone){
			//then hover effect
			var hover_card = mouse_over_card;
			//shoudl this be == noone or != noone
			if (hover_card != noone){ //if player is hovering over a card
				if (hover_card.face_up == true){ //and if the card is face up
					hover_card.target_y = 270; //then lerp up a bit
				}
			} 
		} // else here???
		if (mouse_check_button_pressed(mb_left)){
				//see if the mouse is on top of a card
				audio_play_sound(snd_deal_cards, 1, 0);
				var card_clicked = instance_position(mouse_x, mouse_y, obj_card);
				//if the mouse is colliding with a card
				if (card_clicked != noone){
					//if the card I clicked on in my_hand list
					var in_hand = ds_list_find_index(global.my_hand, card_clicked); //will be -1 if not found
					if (in_hand >= 0){	
						//reference to the index i chose
						my_chosen_index = in_hand;
						//we clicked a card and it's in my_hand
						card_clicked.target_x = 260;
						card_clicked.target_y = 195;
					}
				} 
				global.state = global.state_wait_for_evaluate;
				wait_timer = 40;
			}
				
		
	
		/*
		//see if the player clicked the mouse button
		if (mouse_check_button_pressed(mb_left)){
			//see if the mouse is on top of a card
			var card_clicked = instance_position(mouse_x, mouse_y, obj_card);
			//if the mouse is colliding with a card
			if (card_clicked != noone){
				//if the card I clicked on in my_hand list
				var in_hand = ds_list_find_index(global.my_hand, card_clicked); //will be -1 if not found
				if (in_hand >= 0){	
					//reference to the index i chose
					my_chosen_index = in_hand;
					//we clicked a card and it's in my_hand
					card_clicked.target_x = 260;
					card_clicked.target_y = 195;
				}
			} 
		} else { //IF THE CARD WASNT CLICKED ; mouse check button
			//check to see if player is over card
			var card_clicked = instance_position(mouse_x, mouse_y, obj_card);
			//there is collision with mouse and card
			if (card_clicked != noone){
				//then hover effect
				var hover_card = instance_position(mouse_x, mouse_y, obj_card);
				//shoudl this be == noone or != noone
				if (hover_card != noone){ //if player is hovering over a card
					if (hover_card.face_up == true){ //and if the card is face up
						hover_card.target_y = 270; //then lerp up a bit
					}
				} 
			} else {
				global.state = global.state_wait_for_evaluate;
				wait_timer = 40;
			}
		}
		*/
		
		break;
	case global.state_wait_for_evaluate:
		if (wait_timer > 0){
			//do nothing and wait
			wait_timer -= 1;
		}
		if (wait_timer <= 0){
			//flip opponent's card up
			var their_card = ds_list_find_value(global.their_hand, opponent_chosen_index);
			their_card.face_up = true;
			
			global.state = global.state_evaluate; 
		}

		break;
	case global.state_evaluate:
	var their_card = ds_list_find_value(global.their_hand, opponent_chosen_index);
	var my_card = ds_list_find_value(global.my_hand, my_chosen_index);
		//if other player chose rock
		if(their_card.card_type == global.rock){			
			//if i chose paper
				if(my_card.card_type == global.paper){
					audio_play_sound(snd_win, 1, 0);
					global.my_score += 1;
				}
			
			//if i chose scissors
				if(my_card.card_type == global.scissor){
					audio_play_sound(snd_lose, 1, 0);
					global.their_score += 1;
				}
		}
		//if other player paper
		if(their_card.card_type == global.paper){
			//if i chose rock
			if(my_card.card_type == global.rock){
				audio_play_sound(snd_lose, 1, 0);
				global.their_score += 1;
				}
		

			//if i chose scissors
			if(my_card.card_type == global.scissor){
				audio_play_sound(snd_win, 1, 0);
				global.my_score += 1;
			}
		
		}
		//if other player scissor
		if(their_card.card_type == global.scissor){
			//if i chose rock
			if(my_card.card_type == global.rock){
				audio_play_sound(snd_win, 1, 0);
				global.my_score += 1;
				}
			
			//if i chose paper
			if(my_card.card_type == global.paper){
				audio_play_sound(snd_lose, 1, 0);
				global.their_score += 1;
			}
		}
			
			global.state = global.state_wait_after_evaluate;
			wait_timer = 40;
			
		break;
	case global.state_wait_after_evaluate:
		//another wait_timer
		if (wait_timer > 0){
			//do nothing and wait
			wait_timer -= 1;
		}
		if (wait_timer <= 0){
			//move all cards to discard pile
			//opponent's chosen card, my chosen card, opponent's hand, my hand
			if (card_timer == 0){
				//if their hand has 3 cards then remove opponent's chosen card from their_hand list to discard list
				if(ds_list_size(global.their_hand) == 3){
					var their_card = ds_list_find_value(global.their_hand, opponent_chosen_index);
					//this won't delete the card object from the game
					//it just deletes it from the deck
					ds_list_delete(global.their_hand, opponent_chosen_index);
			
						//should only add 3 cards to their_hand list
						ds_list_add(global.discard_pile, their_card);
				
						//move the sprite to the table
						audio_play_sound(snd_deal_cards, 1, 0);
						their_card.target_x = 510;
						their_card.target_y = 150 - 4*ds_list_size(global.discard_pile);;
						their_card.depth = -1000-ds_list_size(global.discard_pile);
					
				} else if(ds_list_size(global.my_hand) == 3){ //if my hand has 3 cards then remove my chosen card from my_hand list to discard list
					var my_card = ds_list_find_value(global.my_hand, my_chosen_index);
					//this won't delete the card object from the game
					//it just deletes it from the deck
					ds_list_delete(global.my_hand, my_chosen_index);
			
					//should only add 3 cards to their_hand list
					ds_list_add(global.discard_pile, my_card);
				
					//move the sprite to the table
					audio_play_sound(snd_deal_cards, 1, 0);
					my_card.target_x = 510;
					my_card.target_y = 150 - 4*ds_list_size(global.discard_pile);;
					my_card.depth = -1000-ds_list_size(global.discard_pile);
					
				} else if(ds_list_size(global.their_hand) > 0){ //move the rest of the opponent's cards to discard pile
					var their_card = ds_list_find_value(global.their_hand, 0);
					//this won't delete the card object from the game
					//it just deletes it from the deck
					//delete the first card in the list which is 0
					ds_list_delete(global.their_hand, 0);
			
					//add to discard pile list
					ds_list_add(global.discard_pile, their_card);
				
					//move the sprite to the table
					audio_play_sound(snd_deal_cards, 1, 0);
					their_card.target_x = 510;
					their_card.target_y = 150 - 4*ds_list_size(global.discard_pile);;
					their_card.depth = -1000-ds_list_size(global.discard_pile);
					their_card.face_up = true;
				} else if(ds_list_size(global.my_hand) > 0){ //move the rest of the my cards to discard pile
					var my_card = ds_list_find_value(global.my_hand, 0);
					//this won't delete the card object from the game
					//it just deletes it from the deck
					//delete the first card in the list which is 0
					ds_list_delete(global.my_hand, 0);
			
					//add to discard pile list
					ds_list_add(global.discard_pile, my_card);
				
					//move the sprite to the table
					audio_play_sound(snd_deal_cards, 1, 0);
					my_card.target_x = 510;
					my_card.target_y = 150 - 4*ds_list_size(global.discard_pile);
					my_card.depth = -1000-ds_list_size(global.discard_pile);
				} else {
					//ADD TIMER HERE
					if(ds_list_size(global.deck) > 0){
						global.state = global.state_deal_cards;
					} else {
						global.state = global.state_reshuffle;
					}
				}
			}
		}
		
		
		

		break;
	case global.state_reshuffle:
		//cards from discard pile move to original deck location
		reshuffle_timer += 1;
		if(reshuffle_timer == 5){
			reshuffle_timer = 0;
		}
		//move discard cards into global.deck again
		if(ds_list_size(global.discard_pile) > 0 and reshuffle_timer == 0){
			var discarded_card = ds_list_find_value(global.discard_pile, 0);
			ds_list_delete(global.discard_pile, 0);
			
			//add to deck list
			ds_list_add(global.deck, discarded_card);
			
			
			//moving sprite to deck location
			
			discarded_card.target_x = 40;
			discarded_card.target_y = 150;
			
		}
		
		
		//only happens once per game
		if(ds_list_size(global.discard_pile) == 0){
			if(reshuffled == false){
				ds_list_shuffle(global.deck);
			}
			reshuffled = true;
			global.state = global.state_deal_cards;
		}
		
		
		//reshuffle animation
		
		//set diff y values to see all cards again
		//random order in discard_pile


		break;
}