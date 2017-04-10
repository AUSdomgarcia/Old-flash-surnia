package com.surnia.socialStar.ui.component.progressBar.event
{
	import flash.events.Event;

	public class ProgressBarEvent extends Event
	{
		public var params:Object = new Object;
		
		public static const PROGRESS_COMPLETE:String = "inProgressComplete";
		public static const PROGRESSBAR_REMOVE:String = "onProgressBarRemove";
		
		public function ProgressBarEvent(type:String, Params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			params = Params;
			super(type, bubbles, cancelable);
		}
	}
}