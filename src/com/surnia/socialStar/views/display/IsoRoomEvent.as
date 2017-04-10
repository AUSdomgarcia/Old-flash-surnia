package com.surnia.socialStar.views.display 
{
	import flash.events.Event;
	
	public class IsoRoomEvent extends Event
	{			
		/*----------------------------------------------------------------Constant-------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Properties------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		public static const ON_STOP_ISO_OFFICE_PAN:String = "ON_STOP_ISO_OFFICE_PAN";		
		public static const ON_START_PAN:String = "ON_START_PAN";
		public static const ON_STOP_PAN:String = "ON_STOP_PAN";
		public static const ON_CLICK_FLOOR:String = "ON_CLICK_FLOOR";
		public static const ON_CLICK_WALL:String = "ON_CLICK_WALL";
		
		public static const ON_DROP_REWARDS:String = "ON_DROP_REWARDS";		
		//public static const ON_UPDATE_FLOOR_SKIN:String = "ON_UPDATE_FLOOR_SKIN";
		public static const ON_UPDATE_WALL_SKIN:String = "ON_UPDATE_WALL_SKIN";
		
		public static const ON_SET_OFFICE_ROOM_OBJECT_COMPLETE:String = "ON_SET_OFFICE_ROOM_OBJECT_COMPLETE";
		public static const ON_SET_CONTESTANT_COMPLETE:String = "ON_SET_CONTESTANT_COMPLETE";
		
		public static const ON_SET_FRIEND_OFFICE_ROOM_OBJECT_COMPLETE:String = "ON_SET_FRIEND_OFFICE_ROOM_OBJECT_COMPLETE";
		public static const ON_SET_FRIEND_CONTESTANT_COMPLETE:String = "ON_SET_FRIEND_CONTESTANT_COMPLETE";
		
		public static const ON_HIDE_QUEST:String = "ON_HIDE_QUEST";
		public static const ON_SHOW_QUEST:String = "ON_SHOW_QUEST";
		
		public static const ON_ROOM_TILE_EXPANDED:String = "ON_ROOM_TILE_EXPANDED";
		
		public static const ON_GAME_FULL_SCREEN:String = "ON_GAME_FULL_SCREEN";
		public static const ON_GAME_NORMAL_SCREEN:String = "ON_GAME_NORMAL_SCREEN";
		
		private  var _obj:Object = new Object();
		
		/*----------------------------------------------------------------Methods-------------------------------------------------------------*/
		
		public function IsoRoomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super (type, bubbles, cancelable) ;
		}
		
		public override function clone():Event 
		{
			return new IsoRoomEvent(type, bubbles, cancelable);
		} 		
		
		public override function toString():String 
		{ 
			return formatToString("IsoRoomEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		
		/*----------------------------------------------------------------Setters-------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*----------------------------------------------------------------Getters-------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*----------------------------------------------------------------EventHandlers-------------------------------------------------------------*/
		
	}

}