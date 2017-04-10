package com.surnia.socialStar.tutorial.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 *
	 */
	public class TutorialEvent extends Event 
	{
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/		
		public static const START_TUTORIAL:String = "START_TUTORIAL";
		public static const CLICK_SHOP_BTN:String = "CLICK_SHOP_BTN";		
		public static const CLICK_BUY_BTN:String = "CLICK_BUY_BTN";		
		public static const PLACE_STAFF:String = "PLACE_STAFF";
		public static const CLICK_BUBBLE:String = "CLICK_BUBBLE";
		public static const BUY_STAFF:String = "BUY_STAFF";
		public static const CLICK_STAFF:String = "CLICK_STAFF";
		public static const HIRE_CONTESTANT:String = "HIRE_CONTESTANT";
		public static const CLICK_CONTESTANT:String = "CLICK_CONTESTANT";
		public static const CLICK_STAFF_BTN:String = "CLICK_STAFF_BTN";
		public static const HIRE_CREW:String = "HIRE_CREW";
		public static const END_TUTORIAL:String = "END_TUTORIAL";
		
		public static const SHOW_ARROW_GUIDE:String = "SHOW_ARROW_GUIDE";
		public static const SHOW_ARROW_GUIDE_SHOP_BTN:String = "SHOW_ARROW_GUIDE_SHOP_BTN";
		public static const UPDATE_ARROW_GUIDE_SHOP_BTN:String = "UPDATE_ARROW_GUIDE_SHOP_BTN";
		public static const SHOW_NPC_GUIDE:String = "SHOW_NPC_GUIDE";
		
		/*----------------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private  var _obj:Object;		
		/*----------------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		
		public function TutorialEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		
		/*----------------------------------------------------------------------Methods----------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new TutorialEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TutorialEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		
		/*----------------------------------------------------------------------Setters----------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*----------------------------------------------------------------------Getters----------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*----------------------------------------------------------------------EventHandlers----------------------------------------------------------------*/
		
	}
	
}