package com.surnia.socialStar.ui.popUI.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author domz
	 */
	public class XMLEvent extends Event
	{
		public static const LOAD_XML_VALUES:String = "LOAD_XML_VALUES";
		public static const HEAD_DEF_MALE:String = "Male";
		public static const HEAD_DEF_FEMALE:String = "Female";
		
		
		private var _obj:Object = new Object();
		
		public function XMLEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
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