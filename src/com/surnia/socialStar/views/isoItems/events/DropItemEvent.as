package com.surnia.socialStar.views.isoItems.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JC
	 */
	public class DropItemEvent extends Event 
	{
		
		/*-------------------------------------------------------------------------------Constant-----------------------------------------------------------*/
		public static const ON_CLICK_DROP_ITEM:String = "ON_CLICK_DROP_ITEM";
		/*-------------------------------------------------------------------------------Properties-----------------------------------------------------------*/
		private var _obj:Object;
		/*-------------------------------------------------------------------------------Constructor-----------------------------------------------------------*/		
		
		public function DropItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-------------------------------------------------------------------------------Methods-----------------------------------------------------------*/
		
		public override function clone():Event 
		{ 
			return new DropItemEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DropItemEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		
		/*-------------------------------------------------------------------------------Setters-----------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-------------------------------------------------------------------------------Getters-----------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*-------------------------------------------------------------------------------EventHandlers------------------------------------------------------*/
		
	}
	
}