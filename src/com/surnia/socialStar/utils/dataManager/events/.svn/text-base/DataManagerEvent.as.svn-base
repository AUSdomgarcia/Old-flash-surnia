package com.surnia.socialStar.utils.dataManager.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JC
	 */
	public class DataManagerEvent extends Event 
	{
		/*----------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		public static const DATA_MANAGER_COMPLETE:String = "DATA_MANAGER_COMPLETE";
		public static const DATA_MANAGER_FAILED:String = "DATA_MANAGER_FAILED";
		/*----------------------------------------------------------------------Properties------------------------------------------------------------------*/
		private var _obj:Object = new Object();
		/*----------------------------------------------------------------------Constructor-----------------------------------------------------------------*/
		
		
		
		public function DataManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*----------------------------------------------------------------------Methods-------------------------------------------------------------------*/		
		
		public override function clone():Event 
		{ 
			return new DataManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DataManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		
		/*----------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*----------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*----------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		
	}
	
}