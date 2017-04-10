package com.surnia.socialStar.minigames.components.slider 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Drew
	 */
	public class MiniGame_Main_Slider extends Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _slider:MiniGame_Slider;
		private var _sliderController:MiniGame_SliderController;
		private var _sliderView:MiniGame_SliderView;
		public var obstacleListData:Array;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_Main_Slider(raceDuration:int, obstacleInterval:int, uiList:Array, obstacleList:Array, startDelay:int) //duration and interval in seconds 
		{
			init(raceDuration, obstacleInterval, uiList, obstacleList, startDelay);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function init(raceDuration:int, obstacleInterval:int, uiList:Array, obstacleList:Array, startDelay:int):void
		{		
			//-Class
			this._slider = new MiniGame_Slider();
			this._sliderController = new MiniGame_SliderController(this._slider);
			this._sliderController.raceDuration = raceDuration;
			this._sliderController.obstacleInterval = obstacleInterval;
			this._sliderController.obstacleList = obstacleList;
			this._sliderController.uiList = uiList;
			this._sliderController.computeMaxObstacles(raceDuration, obstacleInterval);
			this._sliderView = new MiniGame_SliderView(this._slider, this._sliderController);
			this.addChild(this._sliderView);
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroyMe)
		}
		public function playSlider(isPlaying:Boolean):void
		{
			this._sliderView.startSlider(isPlaying);
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		public function monitorTime(evt:Event):void
		{
			if( this._sliderView != null ){
				this._sliderView.monitorTime(evt.target.timerSeconds, evt.target.timerMinutes);
			}
		}
		public function sliderLoop():void
		{
			if( this._sliderView != null ){
				this._sliderView.sliderLoop();
				this.obstacleListData = this._sliderView.obstacleList;
			}
		}
		private function destroyMe(evt:Event):void
		{
			this._sliderController = null;
			this.removeChild(this._sliderView);
			this._sliderView = null;
		}
	}

}