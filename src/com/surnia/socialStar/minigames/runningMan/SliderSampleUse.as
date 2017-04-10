package com.surnia.socialStar.minigames.runningMan 
{
	import com.surnia.socialStar.minigames.components.obstacle.MiniGame_Obstacle;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_Main_Slider;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_Slider;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_SliderController;
	import com.surnia.socialStar.minigames.components.timer.MiniGame_Timer;
	import com.surnia.socialStar.test.MiniGameRunningManTest;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Drew
	 */
	public class SliderSampleUse extends Sprite 
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _timer:Timer;
		private var _testClass:MiniGame_Main_Slider;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function SliderSampleUse() 
		{
			//-Visual
			//--declare types of obstacles that could be available in slider
			var drum:Ob_Drum = new Ob_Drum();
			var banana:Ob_Banana = new Ob_Banana();
		
			//--declare image types for slider UI
			var sliderBar:Bitmap = new Bitmap(new Slider_Bar());
			var collider:Bitmap = new Bitmap(new Slider_Collider());
			collider.name = "collider";
			//--ui coordinates
			collider.x = 60;
			//--create temporary Holder for visual assets
			var obstacleList:Array = new Array();
			obstacleList.push(null);
			obstacleList.push(drum);
			obstacleList.push(banana);
			var uiList:Array = new Array();
			uiList.push(sliderBar);
			uiList.push(collider);
			//create the slider component
			_testClass = new MiniGame_Main_Slider(60, 3, uiList, obstacleList, 3); //1min(race duration), 3sec(obstacle interval), ui graphics, obstacles in the slider
			addChild(_testClass);
			//_testClass.playSlider(true);
			
			
			//As for example use of timer. This timer class should be on the main class to run an entire mini game.
			var myTimerClass:MiniGame_Timer;
			myTimerClass = new MiniGame_Timer(90); //add game speed to the parameter
			myTimerClass.addEventListener("TimeUpdated", monitorTime);
			myTimerClass.addEventListener("GameLoop", sliderLoop);
			myTimerClass.startClockTimer();
			myTimerClass.startGameTimer();
			//this should be on main class
			//monitors slider's collider state
			//_timer = new Timer(10);
			//_timer.addEventListener(TimerEvent.TIMER, monitorCollision);
			//_timer.start();
			
			//var testP:MiniGameRunningManTest = new MiniGameRunningManTest(stage, this)
			
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function monitorTime(evt:Event):void
		{
			_testClass.monitorTime(evt); //1 second tick
		}
		private function sliderLoop(evt:Event):void
		{
			_testClass.sliderLoop(); //100 ms tick
						//trace(_testClass.colliderState);
		}
		
		private function monitorCollision(evt:TimerEvent):void
		{	

		}

	}

}