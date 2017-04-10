package com.surnia.socialStar.ui.popUI.views.miniMap.components 
{
	import com.surnia.socialStar.minigames.components.player.MiniGamePlayerData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author DF
	 */
	public class Game extends MovieClip
	{
		public var gameMC:MovieClip;
		public var gameLevel:int;
		
		public function Game(parentMain:Sprite,buildingID:String, mc:MovieClip, myPlayer:MiniGamePlayerData,myRival:MiniGamePlayerData, numberOfWeeks:int=1, roundsPerWeek:int=1, raceDuration:int=10, obstacleInterval:int=4, startDelay:int=3) 
		{	
			gameMC = mc;				
			gameMC.setParameters(buildingID, myPlayer, myRival, numberOfWeeks, roundsPerWeek, raceDuration, obstacleInterval, startDelay);
			gameMC.callTest(parentMain);
			
			this.addChild(gameMC);
		}
		
		public function showGame(parentDisplay:DisplayObjectContainer, X:int = 0, Y:int = 0):void {			
			gameMC.show(parentDisplay, X, Y);
			
		}
		
		public function removeGame():void {
			gameMC.remove();
		}		
	}

}