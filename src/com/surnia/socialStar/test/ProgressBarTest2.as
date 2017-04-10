package com.surnia.socialStar.test
{
	
	
	import com.surnia.socialStar.ui.component.progressBarProxy.ProgressBarManagerProxy;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class ProgressBarTest2 extends Sprite
	{
		public function ProgressBarTest2()
		{
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function init(ev:Event = null):void{
			var progressBar:ProgressBarManagerProxy = new ProgressBarManagerProxy();
			progressBar.addProgressBar(2, null);
			
		}
	}
}