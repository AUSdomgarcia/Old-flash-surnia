package com.surnia.socialStar.views.ringCommand.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class RingCommandEvent extends Event 
	{
		
		/*--------------------------------------------------------------------Constant---------------------------------------------------------------------*/
		public static const	ON_SHOW_RING_COMMAND:String = "ON_SHOW_RING_COMMAND";
		public static const	ON_REMOVE_RING_COMMAND:String = "ON_REMOVE_RING_COMMAND";
		
		public static const	ON_MOVE_OFFICE_OBJECT:String = "ON_MOVE_OFFICE_OBJECT";
		public static const	ON_DROP_OFFICE_OBJECT:String = "ON_DROP_OFFICE_OBJECT";
		public static const	ON_ROTATE_OFFICE_OBJECT:String = "ON_ROTATE_OFFICE_OBJECT";
		public static const	ON_SELL_OFFICE_OBJECT:String = "ON_SELL_OFFICE_OBJECT";
		public static const	ON_COLLECT_OFFICE_OBJECT:String = "ON_COLLECT_OFFICE_OBJECT";
		public static const	ON_HIRE_STAFF_OFFICE_OBJECT:String = "ON_HIRE_STAFF_OFFICE_OBJECT";
		public static const	ON_PUT_TO_INVENTORY:String = "ON_PUT_TO_INVENTORY";
		public static const	ON_PUT_TO_INVENTORY_CONTESTANT:String = "ON_PUT_TO_INVENTORY_CONTESTANT";
		
		public static const	ON_SHOW_CONTESTANT_INFO:String = "ON_SHOW_CONTESTANT_INFO";		
		public static const	ON_REST_CONTESTANT:String = "ON_REST_CONTESTANT";
		public static const	ON_SOOTHE_CONTESTANT:String = "ON_SOOTHE_CONTESTANT";
		public static const	ON_CHEER_CONTESTANT:String = "ON_CHEER_CONTESTANT";
		public static const	ON_SHOP_CONTESTANT:String = "ON_SHOP_CONTESTANT";		
		public static const	ON_TRAIN_CONTESTANT:String = "ON_TRAIN_CONTESTANT";
		public static const	ON_PLAY_CONTESTANT:String = "ON_PLAY_CONTESTANT";
		public static const	ON_STOP_CONTESTANT:String = "ON_STOP_CONTESTANT";		
		public static const	ON_FAST_CONTESTANT:String = "ON_FAST_CONTESTANT";
		public static const	ON_FIRE_CONTESTANT:String = "ON_FIRE_CONTESTANT";
		public static const	ON_RECRUIT_CONTESTANT:String = "ON_RECRUIT_CONTESTANT";
		
		public static const	ON_ACTION1_CONTESTANT:String = "ON_ACTION1_CONTESTANT";
		public static const	ON_ACTION1_LOCK_CONTESTANT:String = "ON_ACTION1_LOCK_CONTESTANT";
		public static const	ON_ACTION2_CONTESTANT:String = "ON_ACTION2_CONTESTANT";
		public static const	ON_ACTION2_LOCK_CONTESTANT:String = "ON_ACTION2_LOCK_CONTESTANT";
		
		public static const	ON_STOP_RESTING_CONTESTANT:String = "ON_STOP_RESTING_CONTESTANT";
		public static const	ON_MOVE_CONTESTANT:String = "ON_MOVE_CONTESTANT";	
		
		/*--------------------------------------------------------------------Properties-------------------------------------------------------------------*/
		private var _obj:Object;
		/*--------------------------------------------------------------------Constructor------------------------------------------------------------------*/
		
		
		public function RingCommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*--------------------------------------------------------------------Methods---------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new RingCommandEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("RingCommandEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		/*--------------------------------------------------------------------Setters---------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*--------------------------------------------------------------------Getters---------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*--------------------------------------------------------------------Eventhandlers--------------------------------------------------------------*/
		
	}
	
}