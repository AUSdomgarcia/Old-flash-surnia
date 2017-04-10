package com.surnia.socialStar.minigames
{
	import com.surnia.socialStar.minigames.components.player.MiniGamePlayerData;
	import com.surnia.socialStar.minigames.runningMan.MainRunningMan;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.IGame;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import com.surnia.socialStar.utils.frameRateViewer.FrameRateViewer;
	import com.surnia.socialStar.utils.memoryProfiler.MemoryProfiler;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.Security;

	/**
	 * ...
	 * @author Droids
	 */
	[SWF(backgroundColor="0x000000", frameRate="30", width="1000", height="568")]
	
	public class RunningManTest extends MovieClip implements IGame
	{
		public static const _GAME_WIDTH:Number=646;
		public static const _GAME_HEIGHT:Number=458;
		public static const _GAME_CENTER_WIDTH:Number=_GAME_WIDTH/2;
		public static const _GAME_CENTER_HEIGHT:Number=_GAME_HEIGHT/2;		
		
		private var _parentDisplay:DisplayObjectContainer;
		private var _result:Object;
		private var _parent:Sprite;
		
		private var _mainRunningMan:MainRunningMan;
		public function RunningManTest()
		{
			//Declaration of Parameters
			//var playerList:Array=new Array();
			var playerList:Array=new Array();
			var listImage:Array=new Array();
			var numberOfWeeks:int=1;
			var roundsPerWeek:int=1;
			var raceDuration:int=30;
			var obstacleInterval:int=4;
			var startDelay:int=3;
			var myPlayer:MiniGamePlayerData = new MiniGamePlayerData();
			var myRival:MiniGamePlayerData = new MiniGamePlayerData();
			
			//Player Data
			myPlayer.name ="Drew" //required by running man
			myPlayer.gender =0; //0-male 1-female
			myPlayer.characterId = "PlayerCharID" //required by running man
			myPlayer.myPictureURL=""//"https://graph.facebook.com/1058887045/picture"
			myPlayer.myFacebookID="";
			myPlayer.isPlayer = true; //Current Player
			myPlayer.strength = 50; //required by running man
			myPlayer.inteligence = 1; //required by running man
			myPlayer.singing = 50;
			myPlayer.acting = 50;
			myPlayer.currentRank = 1; //required by running man
			myPlayer.currentLevel = 1; //required by running man
			myPlayer.currentCoins = 1; //required by running man
			myPlayer.currentXp = 1; //required by running man
			myPlayer.currentAp = 1; //required by running man
			myPlayer.charInfo="0100010101010101010101010101010101010101030303030303030303030303030303030303030303030303030303030303030303030303030303030101010101010101010101010101010101010101F160386D2C2CED8A4B792E2EFADCCCDB967C59A8632B3C2C595E38253025C67A64C67A64682C2DD06953DAE3C544453A000000000000000000000000000000000000" //required by running man
			
			//Competitor Data
			myRival.name = "Competitor"; //required by running man
			myRival.gender = 0; //0-male 1-female
			myRival.myPictureURL=""//"https://graph.facebook.com/1646468088/picture";
			myRival.myFacebookID="";
			myRival.characterId = "RivalCharID"; //required by running man
			myRival.isPlayer = false; //Selected Competitor
			myRival.strength = 50; //required by running man
			myRival.inteligence = 60; //required by running man
			myRival.singing = 50;
			myRival.acting = 50;
			myRival.currentRank = 1; //required by running man
			myRival.currentLevel = 1; //required by running man
			myRival.currentCoins = 1; //required by running man
			myRival.currentXp = 1; //required by running man
			myRival.currentAp = 1; //required by running man
			myRival.charInfo = "0100010101010101010101010101010101010101030303030303030303030303030303030303030303030303030303030303030303030303030303030101010101010101010101010101010101010101F160386D2C2CED8A4B792E2EFADCCCDB967C59A8632B3C2C595E38253025C67A64C67A64682C2DD06953DAE3C544453A000000000000000000000000000000000000";
			
			playerList.push(myRival); //Rival must be 1st on array
			playerList.push(myPlayer); //Player must be 2nd

		
			setParameters("99", myPlayer, myRival, numberOfWeeks, roundsPerWeek, raceDuration, obstacleInterval, startDelay);
			
			//show(this, 100, 100)
		}
		
		public function setParameters(buildingId:String, currentPlayerData:MiniGamePlayerData, competitorData:MiniGamePlayerData, numberOfWeeks:int=1, roundsPerWeek:int=1, raceDuration:int=50, obstacleInterval:int=4, startDelay:int=3):void
		{
			_mainRunningMan=new MainRunningMan(buildingId, currentPlayerData, competitorData, numberOfWeeks, roundsPerWeek, raceDuration, obstacleInterval, startDelay);
			//addChild(m);
			show(this, 0, 0);
		}
		
		public function callTest(parent:Sprite):void
		{
			_mainRunningMan.testDispatch(parent);
		}
		private function onClick(e:MouseEvent):void {
			//dispatchResult();			
		}
		
		/* INTERFACE com.surnia.socialStar.ui.popUI.views.miniMap.components.IGame */
		
		public function dispatchResult():void 
		{
			//var params:Object = new Object;
			
			//params.game = this;
			//params.result = _result;
			_parent.dispatchEvent(new MapEvent(MapEvent.TUTORIAL_FINISHED));		
		}
		
		public function get gameResult():Object {
			return _result;
		}
		
		public function show(parentDisplay:DisplayObjectContainer, X:int = 0, Y:int = 0):void 
		{
			_parentDisplay = parentDisplay;
			
			//hide();
			_mainRunningMan.x=X;
			_mainRunningMan.y=Y;
			_parentDisplay.addChild(_mainRunningMan);
			
			//this.x = X;
			//this.y = Y;
			/*
			var fp:FrameRateViewer=new FrameRateViewer();
			this.addChild(fp);
			var sx:MemoryProfiler=new MemoryProfiler();
			this.addChild(sx);*/
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
	}
}