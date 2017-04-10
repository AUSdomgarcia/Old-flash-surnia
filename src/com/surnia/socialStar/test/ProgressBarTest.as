package com.surnia.socialStar.test 
{
	import com.surnia.socialStar.ui.popUI.components.ProgressBarTimer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author domz
	 */

	public class ProgressBarTest extends Sprite 
	{
		private var progressBar:ProgressBarTimer;
		private var barMC:ProgressBarMc = new ProgressBarMc();
		private var barLine:ProgressBarLine = new ProgressBarLine();
		
		public function ProgressBarTest() 
		{
			progressBar = new ProgressBarTimer( barMC, barLine, 0, 60, 10 );
			progressBar.x = 90;
			progressBar.y = 90;
			addChild( progressBar );
			addEventListener( Event.ENTER_FRAME, loop );
		}
		
		private function loop( e:Event ):void {
			progressBar.update();
		}
	}

}