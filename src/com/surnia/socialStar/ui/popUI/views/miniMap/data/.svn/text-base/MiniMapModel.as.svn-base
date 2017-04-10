package com.surnia.socialStar.ui.popUI.views.miniMap.data
	
{
	import com.surnia.socialStar.config.GameConfig;
	import com.surnia.socialStar.controllers.EventSatellite;
	import com.surnia.socialStar.controllers.networking.ServerDataExtractor;
	import com.surnia.socialStar.data.GlobalData;
	import com.surnia.socialStar.data.XMLLinkData;
	import com.surnia.socialStar.events.surniaServer.SSEvent;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.Building;
	import com.surnia.socialStar.ui.popUI.views.miniMap.components.BuildingData;
	import com.surnia.socialStar.ui.popUI.views.miniMap.events.MapEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Capabilities;

	public class MiniMapModel extends Sprite
	{			
		public var _map:mapAnimMC;
		public var _mapNoAnim:mapMC;
		public var _mask:worldMapMC;
		public var mapAllowance:int;	
	
		public var btnOffice:backMC;	
		
		//Building DATA
		public var building:Array =[];					
		public var arrayX:Array = [];	
		public var arrayY:Array = [];				
		public var arrayZ:Array = [];
		public var arrayName:Array = [];
		public var arrayNPCName:Array = [];
		public var arrayNPCFN:Array = [];
		//level requirement
		public var arrayLvreq:Array = [];	
		
		public var arrayFN:Array = [];	
		public var arrayClear:Array = [];		
		public var arrayGamesID:Array = [];
		public var arrayGamesName:Array = [];
		
		public var arrayBuildingReq:Array = [];
		
		//array round
		
		public var roundID:Array = [];
		public var roundType:Array = [];
		public var roundDifficulty:Array = [];
		public var roundOrder:Array = [];
		public var roundStatus:Array = [];
		public var roundDuration:Array = [];
		public var roundCoin:Array = [];
		public var roundAP:Array = [];
		public var roundScript:Array = [];		
		
		//new
		public var arrayBuildingID:Array = [];
		
		public var arrayCurrentGameFN:Array = [];
	
		public var arrayGamesFN:Array = [];	
		public var arrayGames:Array = [];	
		
		public var questCtr:int = 0;	
		
		//Player DATA		
		public var playerName:String;
		public var playerLevel:int;
		public var playerAP:uint;				
		public var playerCoin:uint;
		public var playerExp:uint;
		public var playerFbid:String;	
		public var playerFname:String;
		public var playerID:String;				
		public var	playerLvl:uint;	
		
		public var playerBSExp:uint;
		public var playerBSLvl:uint;
		
		public var playerRSExp:uint;	
		public var playerRSLevel:uint;	
		public var playerSp:uint;
		public var playerPic:String;
		
		public var status:String;
		public var close:backMC;
		
		private var _loadTotal:int = 0;
		private var isAllDataLoaded:Boolean = false;
		private var runingOn:String = "StandAlone";
		private var _gd:GlobalData = GlobalData.instance;
		/*------------------------------------------------------------------------------------------------------------
		 *												CONSTRUCTOR		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function MiniMapModel()
		{		
			runingOn = Capabilities.playerType;			
			trace(this, "runingOn :", runingOn);			
			status = runingOn;
			initialization();
			init();
		}		
		
		/*------------------------------------------------------------------------------------------------------------
		 *												METHODS		
		 * ----------------------------------------------------------------------------------------------------------*/
		public function init():void 
		{
			if (runingOn != 'StandAlone') {
				status = "You are running ONLINE VERSION!!!";
				initBuildingdatas();
			}
			else {
				status = "You are OFFLINE VERSION!!!";	
				
				ServerDataExtractor.instance.updateData(GlobalData.MAPBUILDING_DATA, "bldgs.xml");
				EventSatellite.getInstance().addEventListener(SSEvent.MAPBUILDINGXML_LOADED, onXMLLoaded);				
			}
		}	
		
		//EXTRACT DATA FROM XML
		private function extractPlayerData():void 
		{
			var runingOn:String = Capabilities.playerType;			
			if (runingOn != 'StandAlone') {
				status = "You are running ONLINE VERSION!!!";
				ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, _gd.absPath + "players/ui");
				EventSatellite.getInstance().addEventListener(SSEvent.PLAYERXML_LOADED, onXMLLoadedPlayerData);						
			}
			else {
				status = "You are OFFLINE VERSION!!!";			
				ServerDataExtractor.instance.updateData(GlobalData.PLAYER_DATA, "playerui.xml");
				EventSatellite.getInstance().addEventListener(SSEvent.PLAYERXML_LOADED, onXMLLoadedPlayerData);			
			}
		}		
		
		//INITIALIZE MAP				
		private function initialization():void{
			//initialize map
			_mask = new worldMapMC;	
			
			_mapNoAnim = new mapMC;
			_map = new mapAnimMC;
			
			_map.mask = _mask;
			close = new backMC;			
			mapAllowance = _map.width - GameConfig.GAME_WIDTH;
		}			
		
		//INITIALIZE BUILDING DATAS	
		private function initBuildingdatas():void 
		{
			updateBuildingData();	
			
			for (var j:int = 0; j < GlobalData.instance.mapBuildingDataArray.length; j++ ) {					
				var _buildingMC2:MovieClip = new BuildingNormalMC;		
				var _buildingRedMC2:MovieClip = new BuildingLockedMC;
				var _buildingGrayMC2:MovieClip = new BuildingFinishedMC;	
				
				//arrayGames = GlobalData.instance.getMapBuildingFrameNumbers(arrayName[j]);	
				/*
				for (var i:int = 0; i < arrayGames.length; i++ ) {
					trace(this, "ROUND GAMES :", arrayName[i], " ", arrayGames[i][GlobalData.MAPBUILDING_ROUNDTYPE]);		
				}
				*/
				
				building.push(new Building(new BuildingData(arrayCurrentGameFN[j],arrayGames,_buildingMC2,_buildingRedMC2, _buildingGrayMC2, arrayFN[j], arrayX[j], arrayY[j], arrayName[j], arrayClear[j], arrayBuildingID[j], arrayBuildingReq[j], arrayNPCName[j], arrayNPCFN[j])));
			}			
			
			//add 1 item loaded for building		
			allLoadingComplete(1);
			extractPlayerData();
		}
		
		//UPDATE BUILDING DATA FROM XML
		public function updateBuildingData():void {		
			for (var i:int = 0; i < GlobalData.instance.mapBuildingDataArray.length; i++ ) {				
				//arrayLvreq[i] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_LVLREQ];				
				/*arrayX[i]	= GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_POSITION].x;
				arrayY[i]  = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_POSITION].y;	
				arrayZ[i]  = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_POSITION].z;
				arrayName[i] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_NAME];				
				arrayFN[i] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_FRAMENUMBER];	
				arrayBuildingID[ i ] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_ID];								
				arrayCurrentGameFN[i] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_CURRENTROUND];					
				arrayBuildingReq[i] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_BLDGREQ];
				arrayNPCName[i] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_NPCNAME];
				arrayNPCFN[i] = GlobalData.instance.mapBuildingDataArray[i][GlobalData.MAPBUILDING_NPCFRAMENUMBER];*/
			}
		}	
		
		//UPDATE PLAYER DATA FROM XML
		public function updatePlayerData():void {
			playerBSExp = GlobalData.instance.pBSExp;
			playerBSLvl = GlobalData.instance.pBSLvl;	
			playerRSExp = GlobalData.instance.pRSExp;	
			playerRSLevel = GlobalData.instance.pRSLvl;	
			
			playerFbid = GlobalData.instance.pFbid;	
			playerFname = GlobalData.instance.pFname;
			
			playerID = GlobalData.instance.pId;	
			playerAP = GlobalData.instance.pAp;	
			playerCoin = GlobalData.instance.pCoin;		
			playerExp = GlobalData.instance.pExp;			
			
			playerLvl = GlobalData.instance.pLvl;				
			//this is cash star point
			playerSp = GlobalData.instance.pSp;		
			playerPic = "http://graph.facebook.com/" + playerFbid +"/picture";			
			
			playerID	= playerID;
			playerName  = playerFname;
			playerLevel =  playerLvl;							
		}
		
		
		//CHECKER IF ALL LOADING COMPLETE						
		public function allLoadingComplete(loadCtr:int):void {
			_loadTotal += loadCtr;
			trace(this, "ToTalLoad ", _loadTotal, " ", isAllDataLoaded);
			
			//if 2 items loaded, dispatch complete
			if (_loadTotal >= 2) {
				trace(this, "ALL COMPLETE!");
				
				trace(this, "------------------------------------");
				trace( this, status  );	
				trace(this, "------------------------------------");
				
				if (isAllDataLoaded == false) {
					//set isAllDataLoaded to true to dispatch once
					isAllDataLoaded = true;
					this.dispatchEvent(new MapEvent(MapEvent.LOAD_COMPLETE));
				}
			}
		}		
		
		//EMPTY BUILDING ARRAY			 
		public function emptyBuildingArray():void {			
			for (var i:int = building.length; i > 0; i-- ) {				
				building.pop();
				trace(this, "POP :", building.length );
			}	
		}	
		
		/*------------------------------------------------------------------------------------------------------------
		 *												SETTER		
		 * ----------------------------------------------------------------------------------------------------------*/
		
		 /*------------------------------------------------------------------------------------------------------------
		 *												GETTER		
		 * ----------------------------------------------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------------------------------------
		 *												EVENT HANDLER		
		 * ----------------------------------------------------------------------------------------------------------*/
		
		//ON XML PLAYER DATA LOADED				
		private function onXMLLoadedPlayerData(e:SSEvent):void {	
			EventSatellite.getInstance().removeEventListener(SSEvent.PLAYERXML_LOADED, onXMLLoadedPlayerData);
			
			updatePlayerData();	
			//add 1 item loaded for player
			trace(this, "Player loaded")
			allLoadingComplete(1);
		}
		
		//ON BUILDING DATA XML LOADED		
		public function onXMLLoaded(e:SSEvent):void {
			EventSatellite.getInstance().removeEventListener(SSEvent.MAPBUILDINGXML_LOADED, onXMLLoaded);
			
			updateBuildingData();	
			
			for (var j:int = 0; j < GlobalData.instance.mapBuildingDataArray.length; j++ ){
				var _buildingMC2:MovieClip = new BuildingNormalMC;
				var _buildingRedMC2:MovieClip = new BuildingLockedMC;
				var _buildingGrayMC2:MovieClip = new BuildingFinishedMC;
				
				//arrayGames = GlobalData.instance.getMapBuildingFrameNumbers(arrayName[j]);
				/*
				for (var i:int = 0; i < arrayGames.length; i++ ) {
					trace(this, "ROUND GAMES :", arrayName[i], " ", arrayGames[i][GlobalData.MAPBUILDING_ROUNDTYPE]);		
				}
				*/
				
				building.push(new Building(new BuildingData(arrayCurrentGameFN[j],arrayGames,_buildingMC2,_buildingRedMC2, _buildingGrayMC2, arrayFN[j], arrayX[j], arrayY[j], arrayName[j], arrayClear[j], arrayBuildingID[j],arrayBuildingReq[j],arrayNPCName[j],arrayNPCFN[j] )));
			}
			
			//add 1 item loaded for building			
			allLoadingComplete(1);
			extractPlayerData();
		}
	}
}