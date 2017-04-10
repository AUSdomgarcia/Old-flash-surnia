package com.surnia.socialStar.minigames.components.slider 
{
	import com.surnia.socialStar.minigames.components.obstacle.MiniGame_Obstacle;
	import com.surnia.socialStar.minigames.components.timer.MiniGame_Timer;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Drew
	 */
	public class MiniGame_SliderView extends Sprite
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		public static const UPDATE_OBSTACLE_LIST:String = "UpdateObstacleList";
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _slider:MiniGame_Slider;
		private var _sliderController:MiniGame_SliderController;
		private var _timer:MiniGame_Timer;
		private var _isPlaying:Boolean = false;
		private var _obstacleOnStage:Array;
		
		public var obstacleList:Array;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_SliderView(slider:MiniGame_Slider, sliderController:MiniGame_SliderController) 
		{
			init(slider, sliderController);
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		private function init(slider:MiniGame_Slider, sliderController:MiniGame_SliderController):void
		{
			this._slider = slider;
			this._sliderController = sliderController;
			
			setDisplay();
		}
		private function setDisplay():void
		{
			var list:Array = _slider.uiTypes;
			var maxItem:int = list.length;
			for (var num:int=0; num < maxItem; num++)
			{
				this.addChild(list[num]);
			}
			
			var check:* = this.getChildByName("collider");
			
			if ( check != null ) {
				if( this.contains( check ) ){
					this._slider.addEventListener("UpdateObstacleList", updateObstaclesOnStage);
					this._slider.addEventListener("UpdateObstacleListContent", updateObstacleListData);
				}
			}
			
			//if (this.contains(this.getChildByName("collider"))!=null)
			//{
				
			//}
		}
		private function destroyMe():void
		{
			while (this.numChildren)
			{
				var o:*= this.getChildAt(0);
				//o.removeListener
				this.removeChildAt(0);
			}
		}
		public function startSlider(isPlaying:Boolean):void
		{
			_isPlaying = isPlaying;
		}
		private function renderSlider():void
		{
			var removeObstacle:String;
			this._sliderController.updateObstaclePosition(3); //param speed
			removeObstacle = this._sliderController.checkObstacleOnStage();
			if (removeObstacle != "blank")
			{
				this.removeChild(this.getChildByName(removeObstacle));
			}
		}
		private function checkCollision():void
		{
			var collider:DisplayObject = this.getChildByName("collider");
			var obList:Array =this._obstacleOnStage
			//this.obstacleList = obList;
			var maxLength:int = obList.length;
			for (var num:int = 0; num < maxLength; num++)
			{
				if (obList[num].x >= (collider.x-30)  && obList[num].x <=(collider.x+5))
			    {
					obList[num].reachCollider = "left";
				}
				if (obList[num].x >= ((collider.width-5)+collider.x)  && obList[num].x <=((collider.width)+collider.x))
				{
					obList[num].reachCollider = "right";
				}

				if (obList[num].x > 0 && obList[num].x < (collider.x-30) && obList[num].obstacleOnStage==true)
				{
					obList[num].reachCollider = "finish";
				}
				if(obList[num].x >= (collider.x+5)  && obList[num].x <=(((collider.width/2)-20)+collider.x))
				{
					obList[num].reachCollider = "true";
				}
				if (obList[num].x > 0 && obList[num].x < collider.x-50)
				{
					obList[num].obstacleOnStage = false;
				}
			}
			this._sliderController.updateObstacleListData(obList);
		}
		public function monitorTime(seconds:int, minutes:int):void
		{
			var lapseTime:int = Number(seconds + (minutes * 60));
			if((seconds % _slider.obstacleInterval)==0 && lapseTime <= _slider.raceDuration)
			{
				_sliderController.generateObstacles();
			}
		}
		public function sliderLoop():void
		{
				renderSlider();
				checkCollision();
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
		private function updateObstaclesOnStage(evt:Event):void
		{
			//UPdate List
			this._obstacleOnStage = this._slider.obstacleOnStage;
			this.addChild(_slider.obstacleOnStage[(_slider.obstacleOnStage.length - 1)])

			this.obstacleList=this._slider.obstacleOnStage;
		}
		private function updateObstacleListData(evt:Event):void
		{
			this._obstacleOnStage = this._slider.obstacleOnStage;
			
			this.obstacleList=this._slider.obstacleOnStage;
		}
	}

}