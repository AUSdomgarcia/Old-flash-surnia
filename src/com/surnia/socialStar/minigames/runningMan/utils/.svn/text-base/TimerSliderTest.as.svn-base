package com.surnia.socialStar.minigames.utils 
{
		
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage;

	[SWF( height = '639', width = '760' , frameRate = '30')]
	/**
	 * ...
	 * @author domz
	 */
	public class TimerSliderTest extends Sprite
	{
		private var timerSlider:TimerSlider;
		private var bg:mcMovieSlider = new mcMovieSlider();
		private var collider:ColliderMc = new ColliderMc();
		private var button:ClickBtn = new ClickBtn();
		
		private var counter:Number = 0;
		private var currVal:Number = 0;
		
		// setDefault to run
		
		public function TimerSliderTest()
		{
			initSlider();
		}
		//--------------------------------------------------- SLIDER CLASS --------------------------------------------------------------------------------------------
		private function initSlider():void {
			timerSlider = new TimerSlider( this );
			timerSlider.setBackGround( bg, 140, 220 );
			timerSlider.addCollider( collider, bg.x + 150 , bg.y + collider.height / 2 );
			
			timerSlider.setButton( button, bg.x + 150, bg.y + collider.height / 2 );
			
			timerSlider.setDifficulty( 5, 2, 2, 60);
			timerSlider.couterDelay = timerSlider.defaultTime;
			startGame();
			this.addEventListener("GAME_END", onEnd);
		}
		
		private function startGame():void {
			counter = timerSlider.defaultTime;
			this.addEventListener( Event.ENTER_FRAME, loop );
		}
	
		private function loop( e:Event ):void {
			timerSlider.onUpdate();
		}
		private function onEnd( e:Event ):void {
			this.removeEventListener( Event.ENTER_FRAME, loop );
			trace("Game Done, enter frame remove");
		}
		
		//-------------------------------------------------- GAUGE CLASS ---------------------------------------------------------------------------------------
		
	//end
	}
}