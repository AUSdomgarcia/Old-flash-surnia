package com.surnia.socialStar.ui.popUI.views.miniMap.events
{
	import flash.events.Event;
	
	public class MapEvent extends Event
	{
		public var params:Object = new Object;
		
		public static const GAME_SELECT:String = "game select";
		public static const GAME_FINISHED:String = "game finished";
		public static const TUTORIAL_FINISHED:String = "tutorial finished";
		public static const GAME_CLOSE:String = "game close";
		public static const POPUP_CLOSE:String = "popup close";
		public static const LOAD_COMPLETE:String = "load complete";
		
		public function MapEvent(type:String, Params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			params = Params;
			super(type, bubbles, cancelable);
		}
	}
}