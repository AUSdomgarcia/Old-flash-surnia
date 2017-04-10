package com.surnia.socialStar.ui.playerStatus.event
{
	import flash.events.Event;

	public class PlayerStatusEvent extends Event
	{
		public var params:Object = new Object;
		
		public static const COIN_CLICK:String = "onCoinAddClick";
		public static const CASH_CLICK:String = "onCashAddClick";
		public static const AP_CLICK:String = "onAPAddClick";
		public static const TICKET_CLICK:String = "onTicketClick";
		
		public static const COIN_POPUP:String = "onCoinPopup";
		public static const CASH_POPUP:String = "onCashPopup";
		public static const LEVEL_POPUP:String = "onLevelPopup";
		public static const AP_POPUP:String = "onAPPopup";
		
		public static const DATA_UPDATED:String = "onDataUpdated";
		public static const EXPLIMIT_UPDATED:String = "onExperienceLimitUpdated";
		public static const APLIMIT_UPDATED:String = "onActionPointLimitUpdated";
		public static const ADD_AP:String = "onAddAP";
		public static const EXPERIENCE_MAXED:String = "onExperienceMaxed";
		
		public static const AP_DEPLETED:String = "onAPDepleted";
		public static const STARPOINT_DEPLETED:String = "onStarPointDepleted";
		public static const COIN_DEPLETED:String = "onCoinDepleted";
		
		public static const REDSTAR_MAXED:String = "onHeartMaxed";
		public static const BLACKSTAR_MAXED:String = "onBlackHeartMaxed";
		
		public static const HIDE_PLAYERSTATUS:String = "onHidePlayerStatus";
		public static const SHOW_PLAYERSTATUS:String = "onShowPlayerStatus";
		
		public static const SHOW_REDSTAR:String = "onShowRedStar";
		public static const HIDE_REDSTAR:String = "onHideRedStar";
		public static const SHOW_BLACKSTAR:String = "onShowBlackStar";
		public static const HIDE_BLACKSTAR:String = "onHideBlackStar";
		
		public static const SHOW_HELPINGENERGY:String = "onShowHelpingEnergy";
		public static const HIDE_HELPINGENERGY:String = "onHideHelpingEnergy";
		
		public static const ON_PLAYER_STATUS_UI_ADDED_TO_STAGE:String = "ON_PLAYER_STATUS_UI_ADDED_TO_STAGE";
		
		public function PlayerStatusEvent(type:String, Params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			params = Params;
			super(type, bubbles, cancelable);
		}
	}
}