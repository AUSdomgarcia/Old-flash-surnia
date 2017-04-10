package com.surnia.socialStar.minigames.components.slider 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Drew
	 */
	public class MiniGame_Slider extends EventDispatcher
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		public static const UPDATE_OBSTACLE_POSITION:String = "UpdateObstaclePosition";
		public static const UPDATE_OBSTACLE_LIST:String = "UpdateObstacleList";
		public static const UPDATE_COLLIDER_STATE:String = "UpdateColliderState";
		public static const UPDATE_OBSTACLE_LIST_CONTENT:String="UpdateObstacleListContent"
		//public static const UPDATE_UI_ASSETS:String = "UpdateUiAssets";
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var _raceDuration:int;
		private var _obstacleInterval:int;
		private var _obstacleTypes:Array;
		private var _uiTypes:Array;
		//optional properties ---------------------->
		private var _obstacleOnStage:Array;
		private var _maxObstacles:int;
		private var _colliderState:String;
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function MiniGame_Slider() 
		{
			_obstacleOnStage = new Array();
		}
		/*-----------------------------------------------Methods-----------------------------------------------------*/
		/*-----------------------------------------------Setters-----------------------------------------------------*/
		public function set raceDuration(raceDuration:int):void
		{
			this._raceDuration = raceDuration;
		}
		public function set obstacleInterval(obstacleInterval:int):void
		{
			this._obstacleInterval = obstacleInterval;
		}
		public function set obstacleTypes(obstacleTypes:Array):void
		{
			this._obstacleTypes = obstacleTypes;
		}
		public function set uiTypes(uiTypes:Array):void
		{
			this._uiTypes = uiTypes;
			//dispatchEvent(new Event(UPDATE_UI_ASSETS));
		}
		//optional function ---------------------->
		public function set obstacleOnStage(obstacleOnStage:Array):void
		{
			this._obstacleOnStage = obstacleOnStage;
			dispatchEvent(new Event(UPDATE_OBSTACLE_LIST_CONTENT));
		}
		public function set maxObstacles(maxObstacles:int):void
		{
			this._maxObstacles = maxObstacles;
			dispatchEvent(new Event(UPDATE_OBSTACLE_LIST));
		}
		public function set colliderState(state:String):void
		{
			_colliderState = state;
			dispatchEvent(new Event(UPDATE_COLLIDER_STATE));
		}
		/*-----------------------------------------------Getters-----------------------------------------------------*/
		public function get raceDuration():int
		{
			return this._raceDuration;
		}
		public function get obstacleInterval():int
		{
			return this._obstacleInterval;
		}
		public function get obstacleTypes():Array
		{
			return this._obstacleTypes;
		}
		public function get uiTypes():Array
		{
			return this._uiTypes;
		}
		//optional function ---------------------->
		public function get obstacleOnStage():Array
		{
			return this._obstacleOnStage;
		}
		public function get maxObstacles():int
		{
			return this._maxObstacles;
		}
		public function get colliderState():String
		{
			return _colliderState;
		}
		/*-----------------------------------------------EventHandlers-----------------------------------------------*/
	}

}