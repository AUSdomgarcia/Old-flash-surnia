package com.surnia.socialStar.ui.popUI.views 
{	
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.minigames.events.MiniGameEvent;
	import com.surnia.socialStar.minigames.runningMan.MainRunningMan;
	import com.surnia.socialStar.ui.popUI.components.*;
	import flash.display.*;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class RunningManWrapper extends AbstractWindow
	{
		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/				
		private var _game:MainRunningMan;
		private var _es:EventSatellite;
		private var _miniGameEvent:MiniGameEvent;
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/		
		
		public function RunningManWrapper( windowName:String, windowSkin:MovieClip = null ) 
		{
			super( windowName, windowSkin );
		}
		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		override public function initWindow():void 
		{
			super.initWindow();
			setDisplay();			
		}		
		
		
		override public function clearWindow():void 
		{
			super.clearWindow();				
			removeDisplay();			
		}		
		
		private function setDisplay():void 
		{
			trace( "buildingId", GlobalData.instance.miniGameData.buildingId );
			//trace( "miniGameData============================================>", GlobalData.instance.miniGameData.obj.reference, GlobalData.instance.miniGameData.obj.myPlayer );
			//trace( "data ko====================================================================>>", GlobalData.instance.miniGameData.reference, GlobalData.instance.miniGameData.myPlayer, GlobalData.instance.miniGameData.weakInterval, GlobalData.instance.miniGameData.numberOfRounds, GlobalData.instance.miniGameData.raceDuration,
			//GlobalData.instance.miniGameData.obstacleIntervals, GlobalData.instance.miniGameData.startDelay );
			//_game = new RunningManTest();
			
			
			 //var obj:Object = new Object();
			//obj.reference = this;
			//obj.myPlayer = myPlayer;
			//obj.myRival = myRival;
			//obj.weakInterval = numberOfWeeks;
			//obj.numberOfRounds = 1;
			//obj.raceDuration = raceDuration;
			//obj.raceDuration = 2;
			//obj.obstacleIntervals = obstacleInterval;
			//obj.startDelay = startDelay;	
			//obj.buildingId = "1";
			//obj.roundsPerWeek = roundsPerWeek;
			
			//trace(  " GlobalData.instance.miniGameData.buildingId ", GlobalData.instance.miniGameData.buildingId,
					//" GlobalData.instance.miniGameData.myPlayer ", GlobalData.instance.miniGameData.myPlayer,
					//" GlobalData.instance.miniGameData.myRival ", GlobalData.instance.miniGameData.myRival,
					//" GlobalData.instance.miniGameData.myRival ", GlobalData.instance.miniGameData.weakInterval,
					//" GlobalData.instance.miniGameData.numberOfRounds, ", GlobalData.instance.miniGameData.numberOfRounds,
					//" GlobalData.instance.miniGameData.raceDuration, ", GlobalData.instance.miniGameData.raceDuration,
					//" GlobalData.instance.miniGameData.obstacleIntervals, ", GlobalData.instance.miniGameData.obstacleIntervals,
					//" GlobalData.instance.miniGameData.startDelay, ", GlobalData.instance.miniGameData.startDelay
			//
			//);
			
			_game = new MainRunningMan( GlobalData.instance.miniGameData.buildingId 
										,GlobalData.instance.miniGameData.myPlayer,
										GlobalData.instance.miniGameData.myRival,
										GlobalData.instance.miniGameData.weakInterval,
										GlobalData.instance.miniGameData.numberOfRounds,
										GlobalData.instance.miniGameData.raceDuration,
										GlobalData.instance.miniGameData.obstacleIntervals,
										GlobalData.instance.miniGameData.startDelay );			
			//public function MainRunningMan( buildingId:String, currentPlayerData:MiniGamePlayerData, competitorData:MiniGamePlayerData, numberOfWeeks:int=1, roundsPerWeek:int=1, raceDuration:int=10, obstacleInterval:int=4, startDelay:int=3)
			this.x = 60;
			this.y = 65;
			addChild( _game );			
		}
		
		private function removeDisplay():void 
		{
			if ( _game != null ) {
				if ( this.contains( _game ) ) {
					this.removeChild( _game );
					_game = null;
				}
			}
		}
		
		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
	}

}