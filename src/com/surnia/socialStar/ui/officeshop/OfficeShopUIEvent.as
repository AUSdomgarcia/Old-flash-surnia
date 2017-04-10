package com.surnia.socialStar.ui.officeshop 
{
	import flash.events.Event;
	
	public class OfficeShopUIEvent extends Event
	{
		
		public static const ON_OFFICE_CLOSE:String = "ON_OFFICE_CLOSE";
		public static const ON_OBJECT_BUY:String = "ON_OBJECT_BUY";
		public static const ON_EXPANSION_BUY:String = "ON_EXPANSION_BUY";
		public static const ON_TILE_BUY:String = "ON_TILE_BUY";
		public static const ON_WALL_BUY:String = "ON_WALL_BUY";
		
		
		private  var _obj:Object = new Object();
		
		public function OfficeShopUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super (type, bubbles, cancelable) ;
		}
		
		public override function clone():Event 
		{ 
			return new OfficeShopUIEvent(type, bubbles, cancelable);
		} 
		
		/*----------------
		 * METHODS
		 * --------------*/
		public override function toString():String 
		{ 
			return formatToString("OfficeShopUIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*----------------
		 * SETTER
		 * --------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		/*----------------
		 * GETTER
		 * --------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		
	}

}