package com.surnia.socialStar.ui.avatar 
{
	import flash.events.Event;
	
	public class AvatarTooltipUIEvent extends Event
	{
		public static const ON_AVATAR_TOOLTIP_TRAINING_BUTTON_SELECT:String = "ON_AVATAR_TOOLTIP_TRAINING_BUTTON_SELECT";
		public static const ON_AVATAR_TOOLTIP_STAFF_BUTTON_SELECT:String = "ON_AVATAR_TOOLTIP_STAFF_BUTTON_SELECT";
		public static const ON_AVATAR_TOOLTIP_SHOP_BUTTON_SELECT:String = "ON_AVATAR_TOOLTIP_SHOP_BUTTON_SELECT";
		public static const ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT:String = "ON_AVATAR_TOOLTIP_CLOSE_BUTTON_SELECT";
		
		private  var _obj:Object = new Object();
		
		public function AvatarTooltipUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super (type, bubbles, cancelable) ;
		}
		
		public override function clone():Event 
		{ 
			return new AvatarTooltipUIEvent(type, bubbles, cancelable);
		} 
		
		/*----------------
		 * METHODS
		 * --------------*/
		public override function toString():String 
		{ 
			return formatToString("AvatarTooltipUIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
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