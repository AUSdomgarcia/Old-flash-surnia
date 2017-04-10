package com.surnia.socialStar.ui.popUI.views.characterPanel.event 
{
	import flash.events.Event;
	
	public class CharacterPanelEvent extends Event
	{
		public var params:Object = new Object;
		
		public static const PANEL_CLOSE:String = "panel close";	
		public static const LOAD_COMPLETE:String = "load complete";	
		public static const PROGRAM_SELECT:String = "program select";		
		public static const CHARACTER_SELECT:String = "character select";
		public static const REVENGE_ACCEPTED:String = "revenge accepted";	
		
		public function CharacterPanelEvent(type:String, Params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			params = Params;
			super(type, bubbles, cancelable);
		}
	}

}