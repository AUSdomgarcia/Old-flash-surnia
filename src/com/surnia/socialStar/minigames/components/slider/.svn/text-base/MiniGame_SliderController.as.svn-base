package com.surnia.socialStar.minigames.components.slider 
{
	import com.surnia.socialStar.minigames.components.obstacle.MiniGame_Obstacle;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Drew
	 */
	public class MiniGame_SliderController 
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/		
		private var _slider:MiniGame_Slider;
		private var _obCtr:int;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_SliderController(slider:MiniGame_Slider) 
		{
			this._slider = slider;
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		//update obstacle position
		public function updateObstaclePosition(speed:int):void
		{
			var maxLength:int = this._slider.obstacleOnStage.length;
			for (var num:int = 0; num < maxLength; num++)
			{
				if (this._slider.obstacleOnStage[num].obstacleOnStage==true)
				{
					this._slider.obstacleOnStage[num].x -= speed;
				}
			}
		}
		public function updateObstacleListData(obstacleOnStage:Array):void
		{
			this._slider.obstacleOnStage = obstacleOnStage;
		}
		public function checkObstacleOnStage():String
		{
			var obstacleOnStage:Array = this._slider.obstacleOnStage;
			var maxLength:int = obstacleOnStage.length;
			var ctr:int = 0;
			var obstacleName:String="blank";
			while(ctr<maxLength)
			{
				if (obstacleOnStage[ctr].obstacleOnStage == false)
				{
					//trace("FIRE!" + obstacleOnStage[ctr].obstacleName + "=" + obstacleOnStage[ctr].obstacleOnStage)
					obstacleName = obstacleOnStage[ctr].obstacleName;
					obstacleOnStage.splice(ctr, 1);
					break;
				}
				ctr += 1;
			}
			this._slider.obstacleOnStage = obstacleOnStage;
			return obstacleName;
		}
		public function obstacleReachCollider(index:int, state:Boolean):void
		{
			this._slider.obstacleOnStage[index].reachCollider = state;
		}
		public function removeObstacle(index:int):void
		{
			this._slider.obstacleOnStage.splice(index, 1);
		}
		//randomization of obstacle types
		public function generateObstacles():void
		{
			_obCtr += 1
			var ob:MiniGame_Obstacle;		
			var result:int = createObstacle();
			if (this._slider.obstacleTypes[result]==null)
			{
				ob = new MiniGame_Obstacle("blank", null, "", null);
			}
			else
			{
				ob = new MiniGame_Obstacle("obstacle" + _obCtr, this._slider.obstacleTypes[result], "", null);
			}
			ob.obstacleOnStage= true;
			this._slider.obstacleOnStage.push(ob);
			this._slider.maxObstacles = this._slider.obstacleOnStage.length;
		}
		public function createObstacle():int
		{
			var obstacleTypes:Array = this._slider.obstacleTypes;
			var maxTypes:int = obstacleTypes.length;
			var result:int = Math.floor(Math.random() * maxTypes);
			if (this._slider.obstacleTypes[result] == null)
			{
				var tmp:int = Math.floor(Math.random() * 1);
				if (tmp==1)
				{
					result=Math.floor(Math.random() * maxTypes);
				}
			}
			return result;
		}	
		//update properties of slider model
		public function computeMaxObstacles(duration:int, interval:int):void
		{
			this._slider.maxObstacles = duration / interval;
		}
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		public function set obstacleList(obstacleList:Array):void
		{
			this._slider.obstacleTypes = obstacleList;
		}
		public function set uiList(uiList:Array):void
		{
			this._slider.uiTypes = uiList;
		}
		public function set raceDuration(raceDuration:int):void
		{
			this._slider.raceDuration = raceDuration;
		}
		public function set obstacleInterval(obstacleInterval:int):void
		{
			this._slider.obstacleInterval = obstacleInterval;
		}
		public function set colliderState(state:String):void
		{
			this._slider.colliderState = state;
		}
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
	}

}