package com.surnia.socialStar.ui.popUI.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class PopUIEvent extends Event 
	{
		
		/*------------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		public static const CHANGE_OFFICE_NAME:String = "CHANGE_OFFICE_NAME";		
		
		public static const HIRE_POOR_CHARACTER:String = "HIRE_POOR_CHARACTER";
		public static const HIRE_NORMAL_CHARACTER:String = "HIRE_NORMAL_CHARACTER";
		public static const HIRE_BEST_CHARACTER:String = "HIRE_BEST_CHARACTER";
		
		public static const ASK_ACTION_POINT:String = "ASK_ACTION_POINT";
		public static const GET_ACTION_POINT:String = "GET_ACTION_POINT";
		
		public static const GET_COIN:String = "GET_COIN";
		public static const ASK_COIN:String = "ASK_COIN";
		
		public static const SHOP_ITEM_DATA_READY:String = "SHOP_ITEM_DATA_READY";
		public static const BUY_SHOP_ITEM:String = "BUY_SHOP_ITEM";
		public static const SHOW_FACEBOOK_PAY_WINDOW:String = "SHOW_FACEBOOK_PAY_WINDOW";
		
		public static const SHOW_FRIEND_POPUP_MENU:String = "SHOW_FRIEND_POPUP_MENU";
		
		
		//public static const VISIT_TO_HELP_FRIEND:String = "VISIT_TO_HELP_FRIEND";		
		//public static const VISIT_TO_CHALLENGE_FRIEND:String = "VISIT_TO_CHALLENGE_FRIEND";
		
		public static const GO_BACK_HOME:String = "GO_BACK_HOME";
		
		public static const ON_LOAD_WINDOW:String = "ON_LOAD_WINDOW";		
		public static const ON_LOAD_SUB_WINDOW:String = "ON_LOAD_SUB_WINDOW";
		
		public static const ON_SHOW_MESSAGE:String = "ON_SHOW_MESSAGE";
		public static const ON_UPDATE_MESSAGE_WINDOW:String = "ON_UPDATE_MESSAGE_WINDOW";
		/*------------------------------------------------------------------------Properties-------------------------------------------------------------------*/
		private var _obj:Object = new Object();
		/*------------------------------------------------------------------------Constructor------------------------------------------------------------------*/
		
		public function PopUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 		
		
		/*------------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new PopUIEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PopUIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		/*------------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*------------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*------------------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/
		
	}
	
}