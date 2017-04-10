package com.surnia.socialStar.ui.friendUI.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FriendUIEvent extends Event 
	{
		/*---------------------------------------------------Constant------------------------------------------------------*/
		public static const FRIENDS_DATA_READY:String = "FRIENDS_DATA_READY";
		public static const CLICK_RIGHT_BTN:String = "CLICK_RIGHT_BTN";
		public static const CLICK_RIGHT_BTN2:String = "CLICK_RIGHT_BTN2";
		public static const CLICK_RIGHT_BTN3:String = "CLICK_RIGHT_BTN3";
		
		public static const CLICK_LEFT_BTN:String = "CLICK_LEFT_BTN";
		public static const CLICK_LEFT_BTN2:String = "CLICK_LEFT_BTN2";
		public static const CLICK_LEFT_BTN3:String = "CLICK_LEFT_BTN3";
		
		//public static const UPDATE_SHOP_NAME:String = "UPDATE_SHOP_NAME";
		public static const CLICK_SHOP_NAME:String = "CLICK_SHOP_NAME";		
		public static const CLICK_ADD_FRIENDS:String = "CLICK_ADD_FRIENDS";
		public static const GO_TO_NPC:String = "GO_TO_NPC";		
		
		public static const FRIEND_DATA_COMPLETE:String = "FRIEND_DATA_COMPLETE";
		/*---------------------------------------------------Properties----------------------------------------------------*/
		private  var _obj:Object = new Object();
		/*---------------------------------------------------Constructor---------------------------------------------------*/
		
		
		public function FriendUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*---------------------------------------------------Methods------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new FriendUIEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FriendUIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		
		/*---------------------------------------------------Setters------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		/*---------------------------------------------------Getters------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*---------------------------------------------------EventHandlers------------------------------------------------*/
		
	}
	
}