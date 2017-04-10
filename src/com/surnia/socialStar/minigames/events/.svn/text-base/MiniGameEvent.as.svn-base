package com.surnia.socialStar.minigames.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JC
	 */
	public class MiniGameEvent extends Event 
	{
		/*---------------------------------------------------------------------constant---------------------------------------------------------------------*/
		public static const START_MINI_GAME:String = "START_MINI_GAME";
		public static const END_MINI_GAME:String = "END_MINI_GAME";
		
		public static const SELECT_BUILDING:String = "SELECT_BUILDING";
		public static const CLOSE_BUILDING:String = "CLOSE_BUILDING";
		/*---------------------------------------------------------------------Properties-------------------------------------------------------------------*/
		private var _obj:Object = new Object();
		/*---------------------------------------------------------------------constructor------------------------------------------------------------------*/
		
		public function MiniGameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*---------------------------------------------------------------------Methods------------------------------------------------------------------*/
		
		public override function clone():Event 
		{ 
			return new MiniGameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MiniGameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
		/*---------------------------------------------------------------------Setters------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*---------------------------------------------------------------------Getters------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*---------------------------------------------------------------------EventHandlers-------------------------------------------------------------*/
		
	}
	
}