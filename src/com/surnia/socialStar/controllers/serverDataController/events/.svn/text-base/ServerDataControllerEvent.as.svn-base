package com.surnia.socialStar.controllers.serverDataController.events 
{
	import com.surnia.socialStar.data.contestantData.ContestantData;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JC
	 */
	public class ServerDataControllerEvent extends Event 
	{
		
		/*-----------------------------------------------------------Constant---------------------------------------------------------------------------*/
		public static const PLAYER_COIN_CHANGE:String = "PLAYER_COIN_CHANGE";
		public static const PLAYER_TICKET_CHANGE:String = "PLAYER_TICKET_CHANGE";
		public static const PLAYER_STAR_POINT_CHANGE:String = "PLAYER_STAR_POINT_CHANGE";
		public static const PLAYER_EXPERIENCE_CHANGE:String = "PLAYER_EXPERIENCE_CHANGE";
		public static const PLAYER_LEVEL_CHANGE:String = "PLAYER_LEVEL_CHANGE";		
		public static const PLAYER_HOT_POINT_CHANGE:String = "PLAYER_HOT_POINT_CHANGE";
		public static const PLAYER_ACTION_POINT_CHANGE:String = "PLAYER_ACTION_POINT_CHANGE";
		public static const PLAYER_REDSTAR_CHANGE:String = "PLAYER_REDSTAR_CHANGE";
		public static const PLAYER_BLACKSTAR_CHANGE:String = "PLAYER_BLACKSTAR_CHANGE";
		public static const PLAYER_HELPINGENERGY_CHANGE:String = "PLAYER_HELPINGENERGY_CHANGE";
		public static const PLAYER_CHARACTERHIRED_CHANGE:String = "PLAYER_CHARACTERHIRED_CHANGE";
		public static const PLAYER_CHARACTERLIMIT_CHANGE:String = "PLAYER_CHARACTERLIMIT_CHANGE";
		
		//settings event
		public static const SETTINGS_CHANGE:String = "SETTINGS_CHANGE";
		
		public static const OFFICE_INVENTORY_CHANGE:String = "OFFICE_INVENTORY_CHANGE";
		public static const OFFICE_ITEM_CHANGE:String = "OFFICE_ITEM_CHANGE";
		
		//training event		
		public static const START_TRAINING:String = "START_TRAINING";
		public static const END_TRAINING:String = "END_TRAINING";
		
		//
		public static const AP_TIMER_UPDATED:String = "AP_TIMER_UPDATED";
		public static const AP_TIMER_UPDATED_FAILED:String = "AP_TIMER_UPDATED_FAILED";
		
		//NEW 08122011_520PM
		public static const OFFICE_EXPANDED_COMPLETE:String = "OFFICE_EXPANDED_COMPLETE";
		public static const OFFICE_EXPANDED_FAILED:String = "OFFICE_EXPANDED_FAILED";
		
		public static const BUY_OFFICE_ITEM_COMPLETE:String = "BUY_OFFICE_ITEM_COMPLETE";
		public static const BUY_OFFICE_ITEM_FAILED:String = "BUY_OFFICE_ITEM_FAILED";
		
		public static const SELL_OFFICE_ITEM_COMPLETE:String = "SELL_OFFICE_ITEM_COMPLETE";
		public static const SELL_OFFICE_ITEM_FAILED:String = "SELL_OFFICE_ITEM_FAILED";
		
		public static const REGISTER_OFFICE_ITEM_POS_COMPLETE:String = "REGISTER_OFFICE_ITEM_POS_COMPLETE";		
		public static const REGISTER_OFFICE_ITEM_POS_FAILED:String = "REGISTER_OFFICE_ITEM_POS_FAILED";
		
		public static const SET_OFFICE_ITEM_POS_COMPLETE:String = "SET_OFFICE_ITEM_POS_COMPLETE";		
		public static const SET_OFFICE_ITEM_POS_FAILED:String = "SET_OFFICE_ITEM_POS_FAILED";
		
		public static const MINI_GAME_DATA_SENT_COMPLETE:String = "MINI_GAME_DATA_SENT_COMPLETE";		
		public static const MINI_GAME_DATA_SENT_FAILED:String = "MINI_GAME_DATA_SENT_FAILED";
		
		public static const HIRE_STAFF_COMPLETE :String = "HIRE_STAFF_COMPLETE";
		public static const HIRE_STAFF_FAILED:String = "HIRE_STAFF_FAILED";
		
		public static const HIRE_CREW_COMPLETE :String = "HIRE_CREW_COMPLETE";
		public static const HIRE_CREW_FAILED:String = "HIRE_CREW_FAILED";
		
		public static const DROP_COIN_COMPLETE :String = "DROP_COIN_COMPLETE";
		public static const DROP_COIN_FAILED:String = "DROP_COIN_FAILED";
		
		public static const SAVE_CHAR_DEFINITION_COMPLETE :String = "SAVE_CHAR_DEFINITION_COMPLETE";
		public static const SAVE_CHAR_DEFINITION_FAILED:String = "SAVE_CHAR_DEFINITION_FAILED";
		
		public static const FIRE_CHAR_COMPLETE:String = "FIRE_CHAR_COMPLETE";
		public static const FIRE_CHAR_FAILED:String = "FIRE_CHAR_FAILED";
		
		public static const FIRE_CREW_COMPLETE:String = "FIRE_CREW_COMPLETE";
		public static const FIRE_CREW_FAILED:String = "FIRE_CREW_FAILED";
		
		public static const INVENTORY_DATA_LOAD_COMPLETE:String = "INVENTORY_DATA_LOAD_COMPLETE";	
		public static const INVENTORY_DATA_LOAD_FAILED:String = "INVENTORY_DATA_LOAD_FAILED";
		
		public static const PLACE_TO_INVENTORY_COMPLETE:String = "PLACE_TO_INVENTORY_COMPLETE";
		public static const PLACE_TO_INVENTORY_FAILED:String = "PLACE_TO_INVENTORY_FAILED";
		
		public static const PLACE_CHAR_TO_INVENTORY_COMPLETE:String = "PLACE_CHAR_TO_INVENTORY_COMPLETE";
		public static const PLACE_CHAR_TO_INVENTORY_FAILED:String = "PLACE_CHAR_TO_INVENTORY_FAILED";
		
		public static const PLACE_CHAR_TO_OFFICE_COMPLETE:String = "PLACE_CHAR_TO_OFFICE_COMPLETE";
		public static const PLACE_CHAR_TO_OFFICE_FAILED:String = "PLACE_CHAR_TO_OFFICE_FAILED";
		
		public static const SELL_DRESS_COMPLETE:String = "SELL_DRESS_COMPLETE";
		public static const SELL_DRESS_FAILED:String = "SELL_DRESS_FAILED";		
		
		public static const STRESS_DOWN_CHAR_BY_ITEM_COMPLETE:String = "STRESS_DOWN_CHAR_BY_ITEM_COMPLETE";
		public static const STRESS_DOWN_CHAR_BY_ITEM_FAILED:String = "STRESS_DOWN_CHAR_BY_ITEM_FAILED";
		
		public static const STRESS_DOWN_CHAR_BY_CLICK_COMPLETE:String = "STRESS_DOWN_CHAR_BY_CLICK_COMPLETE";
		public static const STRESS_DOWN_CHAR_BY_CLICK_FAILED:String = "STRESS_DOWN_CHAR_BY_CLICK_FAILED";		
		
		public static const SOOTH_NEIGHBOR_CHAR_COMPLETE:String = "SOOTH_NEIGHBOR_CHAR_COMPLETE";
		public static const SOOTH_NEIGHBOR_CHAR_FAILED:String = "SOOTH_NEIGHBOR_CHAR_FAILED";
		
		public static const SOOTH_CHAR_BY_ITEM_COMPLETE:String = "SOOTH_CHAR_BY_ITEM_COMPLETE";
		public static const SOOTH_CHAR_BY_ITEM_FAILED:String = "SOOTH_CHAR_BY_ITEM_FAILED";
		
		public static const CRY_CHAR_COMPLETE:String = "CRY_CHAR_COMPLETE";
		public static const CRY_CHAR_FAILED:String = "CRY_CHAR_FAILED";
		
		public static const START_TRAIN_COMPLETE:String = "START_TRAIN_COMPLETE";
		public static const START_TRAIN_FAILED:String = "START_TRAIN_FAILED";
		
		public static const END_TRAIN_COMPLETE:String = "END_TRAIN_COMPLETE";
		public static const END_TRAIN_FAILED:String = "END_TRAIN_FAILED";
		
		public static const SOOTH_CHAR_COMPLETE:String = "SOOTH_CHAR_COMPLETE";
		public static const SOOTH_CHAR_FAILED:String = "SOOTH_CHAR_FAILED";
		
		public static const SET_OFFICE_NAME_COMPLETE:String = "SET_OFFICE_NAME_COMPLETE";
		public static const SET_OFFICE_NAME_FAILED:String = "SET_OFFICE_NAME_FAILED";
		
		public static const USED_POWER_ITEM_COMPLETE:String = "USED_POWER_ITEM_COMPLETE";
		public static const USED_POWER_ITEM_FAILED:String = "USED_POWER_ITEM_FAILED";
		
		public static const END_TUTORIAL_IS_COMPLETE:String = "END_TUTORIAL_IS_COMPLETE";
		public static const END_TUTORIAL_IS_FAILED:String = "END_TUTORIAL_IS_FAILED";
		
		public static const UPDATE_QUEST_DATA_COMPLETE:String = "UPDATE_QUEST_DATA_COMPLETE";
		public static const UPDATE_QUEST_DATA_FAILED:String = "UPDATE_QUEST_DATA_FAILED";
		
		public static const END_QUEST_DATA_COMPLETE:String = "END_QUEST_DATA_COMPLETE";
		public static const END_QUEST_DATA_FAILED:String = "END_QUEST_DATA_FAILED";
		
		public static const HELPING_ENERGY_UPDATE_COMPLETE:String = "HELPING_ENERGY_UPDATE_COMPLETE";
		public static const HELPING_ENERGY_UPDATE_FAILED:String = "HELPING_ENERGY_UPDATE_FAILED";
		
		public static const PICK_REWARD_COMPLETE:String = "PICK_REWARD_COMPLETE";
		public static const PICK_REWARD_FAILED:String = "PICK_REWARD_FAILED";
		
		public static const ON_GET_END_QUEST_DATA_COMPLETE:String = "ON_GET_END_QUEST_DATA_COMPLETE";
		public static const ON_GET_END_QUEST_DATA_FAILED:String = "ON_GET_END_QUEST_DATA_FAILED";
		
		public static const ON_ADD_CONTESTANT_STAT_COMPLETE:String = "ON_ADD_CONTESTANT_STAT_COMPLETE";
		public static const ON_ADD_CONTESTANT_STAT_FAILED:String = "ON_ADD_CONTESTANT_STAT_FAILED";
		
		public static const ON_GET_MINIGAME_DATA_COMPLETE:String = "ON_GET_MINIGAME_DATA_COMPLETE";
		public static const ON_GET_MINIGAME_DATA_FAILED:String = "ON_GET_MINIGAME_DATA_FAILED";
		
		public static const ON_SET_OFFICE_OBJECT_IN_USED_COMPLETE:String = "ON_SET_OFFICE_OBJECT_IN_USED_COMPLETE";
		public static const ON_SET_OFFICE_OBJECT_IN_USED_FAILED:String = "ON_SET_OFFICE_OBJECT_IN_USED_FAILED";
		
		public static const ON_UPDATE_WALL_TILE_COMPLETE:String = "ON_UPDATE_WALL_TILE_COMPLETE";
		public static const ON_UPDATE_WALL_TILE_FAILED:String = "ON_UPDATE_WALL_TILE_FAILED";
		
		public static const ON_SAVE_GENDER_COMPLETE:String = "ON_SAVE_GENDER_COMPLETE";
		public static const ON_SAVE_GENDER_FAILED:String = "ON_SAVE_GENDER_FAILED";
		
		//public static const ON_CHECK_OWN_ITEM_COMPLETE:String = "ON_CHECK_OWN_ITEM_COMPLETE";
		//public static const ON_CHECK_OWN_ITEM_FAILED:String = "ON_CHECK_OWN_ITEM_FAILED";
		
		public static const ON_GET_WIDTH_HEIGHT_COMPLETE:String = "ON_GET_WIDTH_HEIGHT_COMPLETE";
		public static const ON_GET_WIDTH_HEIGHT_FAILED:String = "ON_GET_WIDTH_HEIGHT_FAILED";
		
		public static const ON_VISIT_NPC_COMPLETE:String = "ON_VISIT_NPC_COMPLETE";
		public static const ON_VISIT_NPC_FAILED:String = "ON_VISIT_NPC_FAILED";
		
		public static const ON_CLICK_FRIEND_OFFICE_ITEM_COMPLETE:String = "ON_CLICK_FRIEND_OFFICE_ITEM_COMPLETE";
		public static const ON_CLICK_FRIEND_OFFICE_ITEM_FAILED:String = "ON_CLICK_FRIEND_OFFICE_ITEM_FAILED";
		
		public static const ON_CHALLENGE_FRIEND_CONTESTANT_COMPLETE:String = "ON_CHALLENGE_FRIEND_CONTESTANT_COMPLETE";
		public static const ON_CHALLENGE_FRIEND_CONTESTANT_FAILED:String = "ON_CHALLENGE_FRIEND_CONTESTANT_FAILED";
		
		public static const ON_QUEST_VISIT_NEIGHBOR_COMPLETE:String = "ON_QUEST_VISIT_NEIGHBOR_COMPLETE";
		public static const ON_QUEST_VISIT_NEIGHBOR_FAILED:String = "ON_QUEST_VISIT_NEIGHBOR_FAILED";
		
		public static const ON_QUEST_TRAIN_COMPLETE:String = "ON_QUEST_TRAIN_COMPLETE";
		public static const ON_QUEST_TRAIN_FAILED:String = "ON_QUEST_TRAIN_FAILED";
		
		public static const ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_COMPLETE:String = "ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_COMPLETE";
		public static const ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_FAILED:String = "ON_QUEST_STRESS_DOWN_BY_CLICK_CONTESTANT_FAILED";
		
		public static const ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_COMPLETE:String = "ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_COMPLETE";
		public static const ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_FAILED:String = "ON_QUEST_STRESS_DOWN_BY_CLICK_ITEM_FAILED";
		
		public static const ON_QUEST_VISIT_FRIEND_NPC_COMPLETE:String = "ON_QUEST_VISIT_FRIEND_NPC_COMPLETE";
		public static const ON_QUEST_VISIT_FRIEND_NPC_FAILED:String = "ON_QUEST_VISIT_FRIEND_NPC_FAILED";
		
		public static const ON_SET_OLD_TO_NEW_QUEST_COMPLETE:String = "ON_SET_OLD_TO_NEW_QUEST_COMPLETE";
		public static const ON_SET_OLD_TO_NEW_QUEST_FAILED:String = "ON_SET_OLD_TO_NEW_QUEST_FAILED";
		
		public static const ON_ROUTE_CHALLENGE_COMPLETE:String = "ON_ROUTE_CHALLENGE_COMPLETE";
		public static const ON_ROUTE_CHALLENGE_FAILED:String = "ON_ROUTE_CHALLENGE_FAILED";
		
		public static const ON_ROUTE_HELP_COMPLETE:String = "ON_ROUTE_HELP_COMPLETE";
		public static const ON_ROUTE_HELP_FAILED:String = "ON_ROUTE_HELP_FAILED";
		
		public static const ON_GET_RANDOM_FRIEND_CONTESTANT_COMPLETE:String = "ON_GET_RANDOM_FRIEND_CONTESTANT_COMPLETE";
		public static const ON_GET_RANDOM_FRIEND_CONTESTANT_FAILED:String = "ON_GET_RANDOM_FRIEND_CONTESTANT_FAILED";
		
		public static const ON_SET_MINIGAME_DATA_COMPLETE:String = "ON_SET_MINIGAME_DATA_COMPLETE";
		public static const ON_SET_MINIGAME_DATA_FAILED:String = "ON_SET_MINIGAME_DATA_FAILED";		
		
		public static const ON_SET_CONTESTANT_FROM_NEW_TO_OLD_COMPLETE:String = "ON_SET_CONTESTANT_FROM_NEW_TO_OLD_COMPLETE";
		public static const ON_SET_CONTESTANT_FROM_NEW_TO_OLD_FAILED:String = "ON_SET_CONTESTANT_FROM_NEW_TO_OLD_FAILED";
		
		public static const ON_SET_MINIGAME_RESULT_COMPLETE:String = "ON_SET_MINIGAME_RESULT_COMPLETE";
		public static const ON_SET_MINIGAME_RESULT_FAILED:String = "ON_SET_MINIGAME_RESULT_FAILED";
		
		public static const ON_GET_MINIGAME_RESULT_COMPLETE:String = "ON_GET_MINIGAME_RESULT_COMPLETE";
		public static const ON_GET_MINIGAME_RESULT_FAILED:String = "ON_GET_MINIGAME_RESULT_FAILED";
		
		public static const ON_SET_OFFICE_ITEM_USAGE_COMPLETE:String = "ON_SET_OFFICE_ITEM_USAGE_COMPLETE";
		public static const ON_SET_OFFICE_ITEM_USAGE_FAILED:String = "ON_SET_OFFICE_ITEM_USAGE_FAILED";
		
		//public static const ON_GET_SCENE_BUY_COMPLETE:String = "ON_GET_SCENE_BUY_COMPLETE";
		//public static const ON_GET_SCENE_BUY_FAILED:String = "ON_GET_SCENE_BUY_FAILED";
		
		public static const ON_GET_SCENE_COMPLETE:String = "ON_GET_SCENE_COMPLETE";
		public static const ON_GET_SCENE_FAILED:String = "ON_GET_SCENE_FAILED";
		
		public static const ON_FINISH_EVENT_SCENE_COMPLETE:String = "ON_FINISH_EVENT_SCENE_COMPLETE";
		public static const ON_FINISH_EVENT_SCENE_FAILED:String = "ON_FINISH_EVENT_SCENE_FAILED";
		
		public static const ON_CLAIM_COLLECTION_COMPLETE:String = "ON_CLAIM_COLLECTION_COMPLETE";
		public static const ON_CLAIM_COLLECTION_FAILED:String = "ON_CLAIM_COLLECTION_FAILED";
		
		public static const ON_BUY_MATERIAL_COMPLETE:String = "ON_BUY_MATERIAL_COMPLETE";
		public static const ON_BUY_MATERIAL_FAILED:String = "ON_BUY_MATERIAL_FAILED";
		
		public static const ON_BUY_CONSUMABLE_ITEM_COMPLETE:String = "ON_BUY_CONSUMABLE_ITEM_COMPLETE";
		public static const ON_BUY_CONSUMABLE_ITEM_FAILED:String = "ON_BUY_CONSUMABLE_ITEM_FAILED";
		
		public static const ON_CHECK_OWN_ITEM_COMPLETE:String = "ON_CHECK_OWN_ITEM_COMPLETE";
		public static const ON_CHECK_OWN_ITEM_FAILED:String = "ON_CHECK_OWN_ITEM_FAILED";
		
		public static const ON_ACCEPT_QUEST_COMPLETE:String = "ON_ACCEPT_QUEST_COMPLETE";
		public static const ON_ACCEPT_QUEST_FAILED:String = "ON_ACCEPT_QUEST_FAILED";
		
		public static const ON_HIRE_CONTESTANT_COMPLETE:String = "ON_HIRE_CONTESTANT_COMPLETE";
		public static const ON_HIRE_CONTESTANT_FAILED:String = "ON_HIRE_CONTESTANT_FAILED";
		
		public static const ON_UPDATE_CHAR_POSITION_COMPLETE:String = "ON_UPDATE_CHAR_POSITION_COMPLETE";
		public static const ON_UPDATE_CHAR_POSITION_FAILED:String = "ON_UPDATE_CHAR_POSITION_FAILED";
		
		public static const ON_STOP_MACHINE_COMPLETE:String = "ON_STOP_MACHINE_COMPLETE";
		public static const ON_STOP_MACHINE_FAILED:String = "ON_STOP_MACHINE_FAILED";	
		
		public static const ON_REPORT_ERROR_COMPLETE:String = "ON_REPORT_ERROR_COMPLETE";
		public static const ON_REPORT_ERROR_FAILED:String = "ON_REPORT_ERROR_FAILED";	
		
		public static const ON_BUY_WALL_COMPLETE:String = "ON_BUY_WALL_COMPLETE";
		public static const ON_BUY_WALL_FAILED:String = "ON_BUY_WALL_FAILED";
		
		public static const ON_BUY_TILE_COMPLETE:String = "ON_BUY_TILE_COMPLETE";
		public static const ON_BUY_TILE_FAILED:String = "ON_BUY_TILE_FAILED";
		
		public static const ON_MACHINE_COLLECT_COMPLETE:String = "ON_MACHINE_COLLECT_COMPLETE";
		public static const ON_MACHINE_COLLECT_FAILED:String = "ON_MACHINE_COLLECT_FAILED";
		
		public static const ON_CHECK_BOUGHT_CLOTH_ITEM_COMPLETE:String = "ON_CHECK_BOUGHT_CLOTH_ITEM_COMPLETE";
		public static const ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED:String = "ON_CHECK_BOUGHT_CLOTH_ITEM_FAILED";
		
		public static const ON_CHECK_WEARING_CLOTH_ITEM_COMPLETE:String = "ON_CHECK_WEARING_CLOTH_ITEM_COMPLETE";
		public static const ON_CHECK_WEARING_CLOTH_ITEM_FAILED:String = "ON_CHECK_WEARING_CLOTH_ITEM_FAILED";
		
		public static const ON_SET_MINI_GAME_DATA_STORY_MODE_COMPLETE:String = "ON_SET_MINI_GAME_DATA_STORY_MODE_COMPLETE";
		public static const ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED:String = "ON_SET_MINI_GAME_DATA_STORY_MODE_FAILED";		
		
		public static const ON_CHECK_INVITE_FRIENDS_COMPLETE:String = "ON_CHECK_INVITE_FRIENDS_COMPLETE";
		public static const ON_CHECK_INVITE_FRIENDS_FAILED:String = "ON_CHECK_INVITE_FRIENDS_FAILED";
		
		public static const ON_CHECK_HELP_CHALLENGE_COMPLETE:String = "ON_CHECK_HELP_CHALLENGE_COMPLETE";
		public static const ON_CHECK_HELP_CHALLENGE_FAILED:String = "ON_CHECK_HELP_CHALLENGE_FAILED";		
		
		public static const ON_GET_FRIEND_CONTESTANT_COMPLETE:String = "ON_GET_FRIEND_CONTESTANT_COMPLETE";
		public static const ON_GET_FRIEND_CONTESTANT_FAILED:String = "ON_GET_FRIEND_CONTESTANT_FAILED";
		
		public static const ON_CHECKING_IS_CONNECTED_COMPLETE:String = "ON_CHECKING_IS_CONNECTED_COMPLETE";
		public static const ON_CHECKING_IS_CONNECTED_FAILED:String = "ON_CHECKING_IS_CONNECTED_FAILED";
		
		public static const ON_CHECK_CHAR_COUNT_COMPLETE:String = "ON_CHECK_CHAR_COUNT_COMPLETE";
		public static const ON_CHECK_CHAR_COUNT_FAILED:String = "ON_CHECK_CHAR_COUNT_FAILED";
		
		public static const ON_GET_VISITING_REWARD_COMPLETE:String = "ON_GET_VISITING_REWARD_COMPLETE";
		public static const ON_GET_VISITING_REWARD_FAILED:String = "ON_GET_VISITING_REWARD_FAILED";
		
		public static const ON_POST_VISITING_REWARD_COMPLETE:String = "ON_POST_VISITING_REWARD_COMPLETE";
		public static const ON_POST_VISITING_REWARD_FAILED:String = "ON_POST_VISITING_REWARD_FAILED";
		/*-----------------------------------------------------------Properties-------------------------------------------------------------------------*/
		
		private var _obj:Object = new Object();
		private var _contestantData:ContestantData = new ContestantData();
		
		
		/*-----------------------------------------------------------Constructor------------------------------------------------------------------------*/
		
		public function ServerDataControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-----------------------------------------------------------Methods---------------------------------------------------------------------------*/
		
		public override function clone():Event 
		{ 
			return new ServerDataControllerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ServerDataControllerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		/*-----------------------------------------------------------Setters---------------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		public function set contestantData(value:ContestantData):void 
		{
			_contestantData = value;
		}
		/*-----------------------------------------------------------Getters---------------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		
		public function get contestantData():ContestantData 
		{
			return _contestantData;
		}		
		/*-----------------------------------------------------------EventHandlers---------------------------------------------------------------------*/
		
	}
	
}