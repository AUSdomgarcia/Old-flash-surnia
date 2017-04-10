package com.surnia.socialStar.ui.popUI.events
{
	/**
	 * ...
	 * @author domz
	 */
	import flash.events.Event;
	/**
	 * ...
	 * @author domz
	 */
	public class MiniMapPopUpDialogEvent extends Event
	{
		public static const LOAD_BOOLEAN:String = "LOAD_BOOLEAN";
		public static const CLICKED_CLOSE_MAP:String = "CLICKED_CLOSE_MAP";
		
		private var _obj:Object = new Object();
		
		public function MiniMapPopUpDialogEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event 
		{ 
			return new XMLEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String 
		{ 
			return formatToString("NewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get obj():Object 
		{
			return _obj;
		}
		
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
//end
	}
}