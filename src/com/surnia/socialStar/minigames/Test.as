package com.surnia.socialStar.minigames 
{
	import com.surnia.socialStar.controllers.serverDataController.ServerDataController;
	import com.surnia.socialStar.minigames.components.avatar.Avatar;
	import com.surnia.socialStar.minigames.components.obstacle.MiniGame_Obstacle;
	import com.surnia.socialStar.minigames.components.player.MiniGame_Player;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_Main_Slider;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_Slider;
	import com.surnia.socialStar.minigames.components.slider.MiniGame_SliderController;
	import com.surnia.socialStar.minigames.components.timer.MiniGame_Timer;
	import com.surnia.socialStar.minigames.runningMan.RunningManMain;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Drew
	 */
	[SWF(backgroundColor="0x000000", frameRate="30", width="760", height="568")]
	public class Test extends MovieClip
	{
		/*-----------------------------------------------Constant----------------------------------------------------*/
		/*-----------------------------------------------Properties--------------------------------------------------*/
		private var runningMan:RunningManMain;
		private var _char:character;
		
		private var _loader:Loader;
		private var _urlRequest:URLRequest;
		
		
		private var listImage:Array=new Array();
		
		/*-----------------------------------------------Constructor-------------------------------------------------*/
		public function Test() 
		{
			//Image
			loadImage("https://graph.facebook.com/710088564/picture")
			loadImage("https://graph.facebook.com/1646468088/picture")
			//loadGame()
		}
		
		private function collectEndGameResult(evt:Event):void
		{
			
			ServerDataController.getInstance().setReward("runningman", "0", "0", "0", "opponentFBID", "ID", runningMan.playerRecord)
			//runningMan.playerRecord.length
			//trace(runningMan.raceData.winner);
			//trace(runningMan.raceData.looser);
			for(var num:int=0;num<runningMan.playerRecord.length;num++)
			{
				trace(runningMan.playerRecord[num].name +":"+runningMan.playerRecord[num].state)
			}
		}
		private function loadImage(path:String):void
		{
			_loader=new Loader();
			_urlRequest=new URLRequest(path);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			_loader.load(_urlRequest);
		}

		private function loaded(evt:Event):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(evt.target);
			var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, true, 0xFFFFFF);
			//bitmapData.draw(loaderInfo.loader);
			//var bitmap:Bitmap=new Bitmap(bitmapData);
			var sp:Sprite=new Sprite()
			sp.addChild(loaderInfo.loader)
			listImage.push(sp);
			//this.addChild(sp);//---------------------------------------------------------------------------------------------- TRACER ------
			if(listImage.length==2)
			{
				//sp.y=100
				//addChild(sp)
				loadGame();
			}
			else
			{
				//addChild(sp)
			}
		}
		private function loadGame():void
		{
			//Declaration of Parameters
			var playerList:Array=new Array();
			var numberOfWeeks:int;
			var roundsPerWeek:int;
			var raceDuration:int;
			var obstacleInterval:int;
			var startDelay:int;
			var myPlayer:MiniGame_Player = new MiniGame_Player();
			var myRival:MiniGame_Player = new MiniGame_Player();
			
			//Player Data
			myPlayer.name ="Drew" //required by running man
			myPlayer.gender ="Male"
			myPlayer.characterId = "CharID" //required by running man
			myPlayer.myPicture=listImage[1];
			myPlayer.isPlayer = true; //Current Player
			myPlayer.strength = 50; //required by running man
			myPlayer.inteligence = 50; //required by running man
			myPlayer.singing = 50;
			myPlayer.acting = 50;
			myPlayer.currentRank = 1; //required by running man
			myPlayer.currentLevel = 1; //required by running man
			myPlayer.currentCoins = 1; //required by running man
			myPlayer.currentXp = 1; //required by running man
			myPlayer.currentAp = 1; //required by running man
			myPlayer.charInfo="" //required by running man
			
			//Competitor Data
			myRival.name = "Korean"; //required by running man
			myRival.gender = "Male";
			myRival.myPicture=listImage[0];
			myRival.characterId = "CharID"; //required by running man
			myRival.isPlayer = false; //Selected Competitor
			myRival.strength = 50; //required by running man
			myRival.inteligence = 1; //required by running man
			myRival.singing = 50;
			myRival.acting = 50;
			myRival.currentRank = 1; //required by running man
			myRival.currentLevel = 1; //required by running man
			myRival.currentCoins = 1; //required by running man
			myRival.currentXp = 1; //required by running man
			myRival.currentAp = 1; //required by running man
			myRival.charInfo = "1717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717171717";
			
			playerList.push(myRival); //Rival must be 1st on array
			playerList.push(myPlayer); //Player must be 2nd
			
			numberOfWeeks = 1; 
			roundsPerWeek = 1; //number of rounds per week
			raceDuration =10; //60seconds=1 minute
			obstacleInterval = 3; //3 seconds
			startDelay = 3; //3 seconds
			//total Game time = (startDelay*4) + raceDuration
			//listImage[1].x+=100 
			//this.addChild(listImage[0]) //Competitor
			//this.addChild(listImage[1]) //Player
			runningMan = new RunningManMain(playerList, numberOfWeeks, roundsPerWeek, raceDuration, obstacleInterval, startDelay);
			this.addChild(runningMan);
			runningMan.gameEvent.addEventListener("GameFinished", collectEndGameResult);

			//this.addChild(myPlayer.myPicture)
			//listImage[1].y=100
			//this.addChild(myRival.myPicture)
		}
	}

}