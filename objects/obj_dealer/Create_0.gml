/// @description Insert description here
// You can write your code in this editor

global.num_cards = 24; //total size of deck

//create ds_list objects to hold references to the cards
global.deck = ds_list_create();
global.their_hand = ds_list_create();
global.my_hand = ds_list_create();
global.discard_pile = ds_list_create();

//enumerate game states. These don't have to be in order but they all need a different number
global.state_deal_cards = 0;
global.state_they_select = 6;
global.state_my_select = 1;
global.state_wait_for_evaluate = 2;
global.state_evaluate = 3;
global.state_wait_after_evaluate = 4;
global.state_reshuffle = 5;

//this variable tracks which state we're in.
global.state = global.state_deal_cards;

//timer variables
card_timer = 0;
before_they_select_timer = 20;
wait_timer = 0;

//create a number of cards and add them to the global 'deck' list
var rock_counter = 0;
var scissor_counter = 0;
for (i=0; i< global.num_cards; i++){
	//create a new card and store it in a temporary variable
	var newcard = instance_create_layer(40, 150,"Instances", obj_card);
	//set its properties
	newcard.face_up = false;
	newcard.target_x = 40;
	newcard.target_y = 150 - 4*i;
	newcard.depth = -1000 - i;
	if (rock_counter < global.num_cards/3) {
		newcard.card_type = global.rock;	
		rock_counter += 1;
	}
	else if (scissor_counter < global.num_cards/3){
		newcard.card_type = global.scissor;
		scissor_counter += 1;
	}
	else {
		newcard.card_type = global.paper;
	}		
		
	//add the card to the 'deck' list
	ds_list_add(global.deck, newcard);
	
}

//seeds the random number generator so we get fresh random values
randomize() 
//shuffle the deck
ds_list_shuffle(global.deck);

//reposition the cards to match their post-shuffle position
for (i=0; i< global.num_cards; i++){
	var thiscard = global.deck[| i];
	thiscard.target_y = 150 -4*i;
	thiscard.depth = -1000 - i;
}