package com.surnia.socialStar.ui.popUI.views.miniMap.components
{
	//import com.adobe.air.crypto.EncryptionKeyGenerator;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.ui.popUI.views.miniMap.data.MiniMapModel;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Building extends MovieClip
	{
		/*------------------------------------------------------------------------------------------------------------
		 *												VARIABLES		
		 * ----------------------------------------------------------------------------------------------------------*/
		public static const NORMAL_COLOR:int = 0;
		public static const GRAY_COLOR:int = 1;
		public static const RED_COLOR:int = 2;
		
		public static const ROUND_ON_GOING:String = "ongoing";
		public static const ROUND_LOCKED:String = "locked";
		public static const ROUND_DONE:String = "done";
		
		public var building:MovieClip;	
		public var buildingRed:MovieClip;
		public var buildingGray:MovieClip;
		public var buildingLock:LockMC;
		
		public var buildingData:BuildingData;
		public var buildingReq:String;
		
		public var id:String;			
		public var nameBuilding:String = "";
		public var nameNPC:String;
		public var npcFN:int = 1;
		
		public var icon:MovieClip;
		public var fn:uint;
		public var lvlreq:uint=1;	
		public var clear:Boolean;
		public var gameID:Array;
		public var gameName:Array;
		public var currentGameFN:int;
		public var currentGameNewFN:int;
		
		public var X:int;
		public var Y:int;
		
		public var lockX:int;
		public var lockY:int;
		
		public var roundContest:Array = [];
		
		public var roundID:Array = [];
		public var roundType:Array = [];
		public var roundDifficulty:Array = [];
		public var roundOrder:Array = [];
		public var roundLock:Array = [];
		public var roundDuration:Array = [];
		public var roundCoin:Array = [];
		public var roundAP:Array = [];
		public var roundScript:Array = [];		
		
		public var roundLenght:int = 0;
		public var roundFinishTotal:int = 0;
		public var roundOnGoingTotal:int = 0;
		
		public var lockStatus:Boolean = false;
		public var container:Sprite = new Sprite;
		
		public var roundLvlReq:Array = [];
		
		public var npcIsBoss:Array = [];
		public var npcRewardCoin:Array = [];
		public var npcRewardExp:Array = [];
		public var npcCharLvlReq:Array = [];
		
		public var npcDefinition:Array = [];
		public var npcActing:Array = [];
		public var npcHealth:Array = [];
		public var npcIntelligent:Array = [];
		public var npcLvl:Array = [];
		public var npcName:Array = [];
		public var npcAttraction:Array = [];
		public var npcSing:Array = [];
		public var npcGender:Array = [];
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function Building(_buildingData:BuildingData)			
		{		
			buildingData	 = _buildingData;
			building		 = buildingData.building;	
			buildingRed	     = buildingData.buildingRed;
			buildingGray	 = buildingData.buildingGray;			
			
			X = buildingData.X;
			Y = buildingData.Y;
			
			nameBuilding = buildingData.nameBuilding;
			nameNPC 	 = buildingData.nameNPC;
			
			npcFN		 = buildingData.npcFN;
			fn = buildingData.fn;
			id = buildingData.id;
			
			building.gotoAndStop(buildingData.fn);			
			buildingRed.gotoAndStop(buildingData.fn);		
			buildingGray.gotoAndStop(buildingData.fn);		
			
			buildingReq = buildingData.buildingReq;
			
			building.x = X;
			building.y = Y;	
			
			buildingRed.x = X;
			buildingRed.y = Y;
			
			buildingGray.x = X;
			buildingGray.y = Y;
			
			//lvlreq = buildingData.lvlreq;
			clear = buildingData.clear;			
			
			currentGameFN	 = buildingData.currentGameFN;
			
			roundContest = buildingData.roundContest;			
			roundLenght = roundContest.length;
			
			for (var j:int = 0; j < roundContest.length; j++ ) {
				
				/*roundID[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDID];
				roundType[j] 	= roundContest[j][GlobalData.MAPBUILDING_ROUNDTYPE];
				roundDifficulty[j]	= roundContest[j][GlobalData.MAPBUILDING_ROUNDDIFFICULTY];
				roundOrder[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDORDER];
				roundLock[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDLOCK];
				roundDuration[j]	= roundContest[j][GlobalData.MAPBUILDING_ROUNDDURATION];
				roundCoin[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDCOIN];
				roundAP[j]			= roundContest[j][GlobalData.MAPBUILDING_ROUNDAP];
				roundScript[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDBOSSCRIPT];				
				
				roundLvlReq[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDLVLREQ];
				
				npcIsBoss[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCISBOSS];
				npcRewardCoin[j]	= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCREWARDCOIN];
				npcRewardExp[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCREWARDEXP];			
				
				npcDefinition[j]	= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCBODYDEF];
				npcActing[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCACTING];
				npcHealth[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCHEALTH];
				npcIntelligent[j]	= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCINTELLIGENT];
				npcLvl[j]			= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCLVL];
				npcName[j]			= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCNAME];
				npcAttraction[j]	= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCNPCATTRACTION];
				npcSing[j]			= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCSING];	
				
				npcGender[j]		= roundContest[j][GlobalData.MAPBUILDING_ROUNDNPCGENDER];*/
				
				
				if (roundLock[j] == ROUND_DONE) {
					roundFinishTotal++;
				}		
				if (roundLock[j] == ROUND_ON_GOING) {
					roundOnGoingTotal++;
				}	
				//roundOnGoingTotal
			}
			
			//sortRoundBy(roundContest, GlobalData.MAPBUILDING_ROUNDORDER);	
			
			initialization();
			displayBuilding();
		}
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS		
		 * ----------------------------------------------------------------------------------------------------------*/
		//SORT ROUND CONTEST
		public function sortRoundBy(sortArray:Array, sortByIndex:int):void {
			var temp:Array = [];
			for (var i:int = 0; i < sortArray.length; i++ ) {
				for (var j:int = 0; j < sortArray.length; j++ ) {
					if (sortArray[i][sortByIndex] < sortArray[j][sortByIndex]) {
						temp[i] = sortArray[i];
						sortArray[i] = sortArray[j];
						sortArray[j] = temp[i];
					}
				}
			}
		}
		
		//INITIALIZATION
		private function initialization():void {
			buildingLock = new LockMC;
			
			lockX = (building.width / 2) - (buildingLock.width / 2) + X;
			lockY = (building.height / 2) - (buildingLock.height / 2) + Y;
			
			buildingLock.x = lockX;
			buildingLock.y = lockY;
		}
		
		//DISPLAY BUILDING
		private function displayBuilding():void{
			container = building;
			this.addChild(container);			
		}
		
		//SWITCH DISPLAY NORMAL BUILDING
		public function switchNormal():void {			
			lockStatus = false;
			if (buildingLock != null) {
				if (this.contains(buildingLock)) {
					removeChild(buildingLock);
				}
			}
			
			if (container != null) {
				if (this.contains(container)) {
					this.removeChild(container);
				}
			}
			container = building;
			this.addChild(container);
		}
		
		//SWITH DISPLAY LOCK BUILDING
		public function switchLocked():void {	
			
			lockStatus = true;
			if (buildingLock != null) {
				if (this.contains(buildingLock)) {
					removeChild(buildingLock);
				}
			}
			//container = buildingRed;
			//this.addChild(container);	
			
			addChild(buildingLock);
		}
		
		//SWITCH DISPLAY FINISH BUILDING
		public function switchFinished():void {	
			
			lockStatus = false;
			if (buildingLock != null) {
				if (this.contains(buildingLock)) {
					removeChild(buildingLock);
				}
			}
			
			if (container != null) {
				if (this.contains(container)) {
					removeChild(container);
				}
			}
			container = buildingGray;
			this.addChild(container);
		}		
	}
}