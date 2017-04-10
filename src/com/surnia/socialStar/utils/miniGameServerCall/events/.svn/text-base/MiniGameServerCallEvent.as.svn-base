package com.surnia.socialStar.utils.miniGameServerCall.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MiniGameServerCallEvent extends Event 
	{
		/*-----------------------------------------------------------------------------------Constant---------------------------------------------------*/
		public static const QUEST_DATA_LOADED_COMPLETE:String = "QUEST_DATA_LOADED_COMPLETE";
		public static const QUEST_DATA_LOADED_FAILED:String = "QUEST_DATA_LOADED_FAILED";
		/*-----------------------------------------------------------------------------------Properties-------------------------------------------------*/
		private var _obj:Object =  new Object();
		/*-----------------------------------------------------------------------------------Constructor-------------------------------------------------*/
		
		
		
		
		public function MiniGameServerCallEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MiniGameServerCallEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MiniGameServerCallEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		/*-----------------------------------------------------------------------------------Methods---------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------Setters---------------------------------------------------*/
		
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-----------------------------------------------------------------------------------Getters---------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*-----------------------------------------------------------------------------------EventHandlers----------------------------------------------*/
		
	}
	
}