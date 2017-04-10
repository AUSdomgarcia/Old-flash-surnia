package com.surnia.socialStar.ui.questUI.event
{
	import flash.events.Event;

	public class QuestEvent extends Event
	{
		public static const SHOW_NPCVIEW:String = "onShowNPCView";
		public static const SHOW_POPVIEW:String = "onShowPOPView";
		public static const SHOW_SCROLLERVIEW:String = "onShowScrollView";
		public static const HIDE_NPCVIEW:String = "onHideNPCView";
		public static const HIDE_POPVIEW:String = "onHidePOPView";
		public static const HIDE_SCROLLERVIEW:String = "onHideScrollView";
		
		public var params:Object = new Object(); 
		public function QuestEvent(type:String, Params:Object, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super (type, bubbles, cancelable);
			params = Params;
		}
	}
}