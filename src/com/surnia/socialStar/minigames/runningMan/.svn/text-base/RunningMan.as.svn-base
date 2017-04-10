package com.surnia.socialStar.minigames.runningMan
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Droids
	 */
	public class RunningMan extends EventDispatcher
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		public static const GAME_FINISHED:String = "GameFinished";
		
		public static const PLAYERLIST_UPDATED:String ="PlayerListUpdated";
		public static const INPUTLIST_UPDATED:String="InputListUpdated";
		public static const AVATARLIST_UPDATED:String="AvatarListUpdated";
		
	    public static const UPDATE_OBSTACLE_LIST:String = "UpdateObstacleList";
		public static const UPDATE_OBSTACLE_LIST_CONTENT:String="UpdateObstacleListContent"
		
		public static const REMOVED_OBSTACLE:String="RemovedObstacle";
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		public var numberOfWeeks:int;
		public var roundsPerWeek:int;
		public var raceDuration:int;
		public var obstacleInterval:int;
		public var startDelay:int;
		public var maxGames:int;
		public var maxGameTime:int;
		
		public var raceData:Object;
		public var masterRecord:Object;
		
		public var layersList:Array;
		
		private var _gameState:String;
		
		private var _playerList:Array;
		private var _inputList:Array;
		private var _avatarList:Array;
		
		private var _obstacleList:Array;
		private var _obstacleTypes:Array;
		private var _maxObstacles:int;
		
		public var awardTypes:Array;
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		public function RunningMan()
		{
			this._inputList=new Array();
			this._obstacleList=new Array();
			this.raceData=new Object();
			this.masterRecord=new Object();
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		public function dispatchRemoveObstacle():void
		{
		    this.dispatchEvent(new Event(REMOVED_OBSTACLE));
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		public function set gameState(state:String):void
		{
			this._gameState=state;
			if(state=="GAME_END")
			{
				this.dispatchEvent(new Event(GAME_FINISHED));
			}				
		}
		public function set playerList(list:Array):void
		{
			this._playerList=list;
			this.dispatchEvent(new Event(PLAYERLIST_UPDATED));
		}
		public function set inputList(list:Array):void
		{
			this._inputList=list;
			this.dispatchEvent(new Event(INPUTLIST_UPDATED));
		}
		public function set avatarList(list:Array):void
		{
			this._avatarList=list;
			this.dispatchEvent(new Event(AVATARLIST_UPDATED));
		}
		public function set obstacleList(list:Array):void
		{
			this._obstacleList=list;
			this.dispatchEvent(new Event(UPDATE_OBSTACLE_LIST_CONTENT));
		}
		public function set obstacleTypes(obstacleTypes:Array):void
		{
			this._obstacleTypes = obstacleTypes;
		}
		public function set maxObstacles(maxObstacles:int):void
		{
			this._maxObstacles = maxObstacles;
			dispatchEvent(new Event(UPDATE_OBSTACLE_LIST));
		}
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		public function get gameState():String
		{
			return this._gameState; 
		}
		public function get playerList():Array
		{
			return this._playerList;
		}
		public function get inputList():Array
		{
			return this._inputList;
		}
		public function get avatarList():Array
		{
			return this._avatarList;
		}
		public function get obstacleList():Array
		{
			return this._obstacleList;
		}
		public function get obstacleTypes():Array
		{
			return this._obstacleTypes;
		}
		public function get maxObstacles():int
		{
			return this._maxObstacles;
		}
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
	}
}