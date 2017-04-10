package com.surnia.socialStar.minigames.runningMan
{
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.minigames.components.miniGameTemplate.miniGameTemplate;
	import com.surnia.socialStar.minigames.components.player.MiniGamePlayerData;
	import com.surnia.socialStar.minigames.events.MiniGameEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	//import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	

	/**
	 * ...
	 * @author Droids
	 */
	public class MainRunningMan extends miniGameTemplate // implements IGame
	{
		/*-----------------------------------------------Constant---------------------------------------------------------*/
		/*-----------------------------------------------Properties-------------------------------------------------------*/
		private var _numberOfWeeks:int;
		private var _roundsPerWeek:int;
		private var _raceDuration:int;
		private var _obstacleInterval:int;
		private var _startDelay:int;
		
		private var _buildingID:String;
		//private var _parentDisplay:DisplayObjectContainer;
		//private var _result:Object;
		//private var _parent:Sprite;
		
		private var _model:RunningMan;
		private var _controller:RunningManController;
		private var _view:RunningManView;
		
		public var myParent:Sprite;
		
		//new
		private var _es:EventSatellite;
		private var _miniGameEvent:MiniGameEvent;		
		/*-----------------------------------------------Constructor------------------------------------------------------*/
		//public function MainRunningMan( buildingId:String, currentPlayerData:MiniGamePlayerData, competitorData:MiniGamePlayerData, numberOfWeeks:int=1, roundsPerWeek:int=1, raceDuration:int=10, obstacleInterval:int=4, startDelay:int=3)
		public function MainRunningMan( buildingId:String, currentPlayerData:MiniGamePlayerData, competitorData:MiniGamePlayerData, numberOfWeeks:int, roundsPerWeek:int, raceDuration:int, obstacleInterval:int, startDelay:int)
		{
			//_parent=parent;
			init(buildingId, numberOfWeeks, roundsPerWeek, raceDuration, obstacleInterval, startDelay);
			super(currentPlayerData, competitorData);
		}
		/*-----------------------------------------------Methods----------------------------------------------------------*/
		private function init(buildingId:String, numberOfWeeks:int, roundsPerWeek:int, raceDuration:int, obstacleInterval:int, startDelay:int):void
		{
			_miniGameEvent = new MiniGameEvent( MiniGameEvent.START_MINI_GAME );
			_es = EventSatellite.getInstance();
			_es.dispatchESEvent( _miniGameEvent );
			
			this._buildingID=buildingId;
			this._numberOfWeeks=numberOfWeeks;
			this._roundsPerWeek=roundsPerWeek;
			this._raceDuration=raceDuration;
			this._obstacleInterval=obstacleInterval;
			this._startDelay=startDelay;
		}
		protected override function startGame():void
		{
			var playerList:Array=new Array();
			playerList.push(this.competitorData);
			playerList.push(this.currentPlayerData);
			this._model=new RunningMan();
			this._controller=new RunningManController(this._model);
			this._controller.numberOfWeeks=this._numberOfWeeks;
			this._controller.roundsPerWeek=this._roundsPerWeek;
			this._controller.raceDuration=this._raceDuration;
			this._controller.obstacleInterval=this._obstacleInterval;
			this._controller.startDelay=this._startDelay;
			this._controller.playerList=playerList;
			this._controller.computeRaceDuration();
			this._view=new RunningManView(this._model, this._controller);
			this._model.addEventListener("GameFinished", collectEndGameResult);
			this.addChild(this._view);			
		}
		public function testDispatch(parentLink:Sprite):void
		{
			myParent=parentLink;
		}
		/*-----------------------------------------------Setters----------------------------------------------------------*/
		/*-----------------------------------------------Getters----------------------------------------------------------*/
		/*-----------------------------------------------EventHandlers----------------------------------------------------*/
		protected override function collectEndGameResult(evt:Event):void
		{
			//2nd to last
			_miniGameEvent = new MiniGameEvent( MiniGameEvent.END_MINI_GAME );
			_es = EventSatellite.getInstance();
			_es.dispatchESEvent( _miniGameEvent );
			ServerDataController.getInstance().setReward(this._model.masterRecord.gameName, this._model.masterRecord.apEarned, this._model.masterRecord.coinEarned, this._model.masterRecord.xpEarned, competitorData.characterId, currentPlayerData.characterId, this._model.masterRecord.winner, this._model.masterRecord.playerRecord , this._buildingID)
			
			
			//myParent.dispatchEvent(new MapEvent(MapEvent.TUTORIAL_FINISHED));
			//this._result= this._model.masterRecord;
			//this.dispatchResult();
			//destroy();
			//trace("GAME ENDZZZ")
		}
		
		//private function onClick(e:MouseEvent):void {
		//	dispatchResult();			
		//}
		/* INTERFACE com.surnia.socialStar.ui.popUI.views.miniMap.components.IGame */
		/*public function dispatchResult():void 
		{
			//var params:Object = new Object;
			//params.game = this;
			//params.result = _result;
			//_parent.dispatchEvent(new MapEvent(MapEvent.GAME_FINISHED));		
		}
		
		public function get gameResult():Object{
			return _result;
		}
		
		public function show(parentDisplay:DisplayObjectContainer, X:int = 0, Y:int = 0):void 
		{
			_parentDisplay = parentDisplay;
			
			//hide();
			_parentDisplay.addChild(this);
			
			this.x = X;
			this.y = Y;
		}
		
		public function remove():void 
		{			
			if (_parentDisplay != null) {			
				if (this != null) {
					
					_parentDisplay.removeChild(this);
				}
			}
		}
		
		public function get visibility():Boolean 
		{
			return this.visible;
		}
		*/
	}
}